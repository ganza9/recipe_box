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
  recipe = Recipe.new({:name => title, :instruction => instruction, :rating => rating, :cooking_time => cooking_time, :prep_time => prep_time})
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
  title = params.fetch('name')
  rating = params.fetch('rating')
  instruction = params.fetch('instruction')
  prep_time = params.fetch('prep')
  cooking_time = params.fetch('cooking')
  tags = (params.key?('tag') ? params.fetch('tag') : [])
  ingredients = (params.key?('ingredient') ? params.fetch('ingredient') : [])
  recipe = Recipe.find(id)
  tags.each do |tag|
    recipe.tags.create({:name => tag})
  end
  ingredients.each do |ingredient|
    recipe.ingredients.create({:name => ingredient})
  end
  Recipe.update(id, :name => title, :instruction => instruction,:rating => rating,:cooking_time => cooking_time, :prep_time =>  prep_time )
  redirect to("/recipe/#{id}")
end

delete('/delete_ingredient/:id/:name') do
  id = params[:id].to_i
  name = params[:name]
  recipe = Recipe.find(id)
  ingredient = Ingredient.find_by(name: name)
  recipe.ingredients.destroy(ingredient)
  redirect to("/edit/#{id}")
end

delete('/delete_tag/:id/:name') do
  id = params[:id].to_i
  name = params[:name]
  recipe = Recipe.find(id)
  tag = Tag.find_by(name: name)
  recipe.tags.destroy(tag)
  redirect to("/edit/#{id}")
end
