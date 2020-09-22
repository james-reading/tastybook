class AddHeadingToIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :heading, :boolean, null: false, default: false
  end
end
