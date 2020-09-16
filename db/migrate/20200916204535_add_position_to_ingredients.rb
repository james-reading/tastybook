class AddPositionToIngredients < ActiveRecord::Migration[6.0]
  def up
    add_column :ingredients, :position, :integer

    Recipe.find_each do |recipe|
      recipe.ingredients.each.with_index(1) do |ingredient, index|
        ingredient.update_column :position, index
      end
    end
  end

  def down
    remove_column :ingredients, :position
  end
end
