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
