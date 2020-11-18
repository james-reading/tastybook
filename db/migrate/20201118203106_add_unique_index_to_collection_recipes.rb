class AddUniqueIndexToCollectionRecipes < ActiveRecord::Migration[6.0]
  def change
    add_index :collection_recipes, [:collection_id, :recipe_id], unique: true
  end
end
