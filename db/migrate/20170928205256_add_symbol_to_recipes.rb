class AddSymbolToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column(:recipes, :prep_time_symbol, :string)
    add_column(:recipes, :cooking_time_symbol, :string)
  end
end
