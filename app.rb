require("bundler/setup")
require('pry')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get('/')do
  @recipes = Recipe.all()
  erb(:index)
end

get('/form')do
  erb(:form)
end

post("/")do
  title = params.fetch('name')
  tags = params.fetch('tag')
  ingredients = params.fetch('ingredient')
  rating = params.fetch('rating')
  instruction = params.fetch('instruction')
  prep_time = params.fetch('prep')
  cooking_time = params.fetch('cooking')
  img = params.fetch('img')
  prep_time_symbol = params.fetch('prep-symbol')
  cooking_time_symbol = params.fetch('cooking-symbol')
  recipe = Recipe.new({:name => title, :instruction => instruction, :rating => rating, :cooking_time => cooking_time, :prep_time => prep_time, :cooking_time_symbol => cooking_time_symbol, :prep_time_symbol => prep_time_symbol, :img => img})
  recipe.save()
  tags.each do |tag|
    recipe.tags.create({:name => tag})
  end
  ingredients.each do |ingredient|
    recipe.ingredients.create({:name => ingredient})
  end
  redirect to('/')
end

get('/recipe/:id')do
  id = params[:id].to_i
  @recipe = Recipe.find(id)
  name = @recipe.name.downcase()
  @img = name.gsub(' ','')
  @instructions = @recipe.instruction.split("@")
  erb(:recipe_detail)
end

get('/edit/:id') do
  id = params[:id].to_i
  @recipe = Recipe.find(id)
  erb(:recipe_edit)
end

patch('/edit/:id') do
  id = params[:id].to_i
  rating = params.fetch('rating')
  instruction = params.fetch('instruction')
  prep_time = params.fetch('prep')
  cooking_time = params.fetch('cooking')
  tags = (params.key?('tag') ? params.fetch('tag') : [])
  ingredients = (params.key?('ingredient') ? params.fetch('ingredient') : [])
  recipe = Recipe.find(id)
  recipe.tags.each do |tag|
    if tag.name != ""
      name = params.fetch(tag.name)
      if name == "delete"
        recipe.tags.destroy(tag)
      end
    else
      recipe.tags.destroy(tag)
    end
  end
  recipe.ingredients.each do |ingredient|
    if ingredient.name != ""
      name = params.fetch(ingredient.name)
      if name == "delete"
        recipe.ingredients.destroy(ingredient)
      end
    else
      recipe.ingredients.destroy(ingredient)
    end
  end

  tags.each do |tag|
    if tag != "delete"
      new_tag = Tag.find_or_initialize_by({:name => tag})
      if new_tag.id
        recipe.tags.push(new_tag)
      else
        new_tag.save()
        recipe.tags.push(new_tag)
      end
    end
  end

  ingredients.each do |ingredient|
    if ingredient != "delete"
      new_ingredient = Ingredient.find_or_initialize_by({:name => ingredient})
      if new_ingredient.id
        recipe.ingredients.push(new_tag)
      else
        new_ingredient.save()
        rrecipe.ingredients.push(new_tag)
      end
    end
  end

  Recipe.update(id, :instruction => instruction,:rating => rating,:cooking_time => cooking_time, :prep_time =>  prep_time, :cooking_time_symbol => cooking_time_symbol, :prep_time_symbol => prep_time_symbol, :img => img)
  redirect to("/recipe/#{id}")
end

delete('/delete/:id') do
  recipe_id = params[:id].to_i
  Recipe.where(id: recipe_id).destroy_all
  redirect to("/")
end
