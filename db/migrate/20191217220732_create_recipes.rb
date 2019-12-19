class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :name, null: false, default: ''
      t.references :cuisine, null: false, foreign_key: true, index: true
      t.string :length
      t.integer :servings
      t.string :link

      t.timestamps null: false
    end
  end
end
