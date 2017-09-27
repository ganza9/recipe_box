class Recipe < ActiveRecord::Base
  has_and_belongs_to_many(:tags)
  has_and_belongs_to_many(:ingredients)
  validates(:name, {:presence => true, :uniqueness => true})
  before_save(:word_format)


  def word_format
    self.name = self.name.capitalize()
    self.instruction = self.instruction.capitalize()
  end
end
