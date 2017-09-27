require("bundler/setup")
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
  tag = params.fetch('tag')
  ingredient = params.fetch('ingredient')
  rating = params.fetch('rating')
  recipe = params.fetch('recipe')

end
