class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.references :recipe, null: false, foreign_key: true, index: true
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
