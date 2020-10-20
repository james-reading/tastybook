class AddVegetarianToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :vegetarian, :boolean, null: false, default: false
    add_column :recipes, :vegan, :boolean, null: false, default: false
  end
end
