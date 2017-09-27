class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many(:recipes)
  validates(:name, {:uniqueness => true})
  before_save(:word_format)


  def word_format
    self.name = self.name.capitalize()
  end

end
