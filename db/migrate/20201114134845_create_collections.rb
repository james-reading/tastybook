class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description, null: false, default: ''
      t.integer :recipes_count, null: false, default: 0
      t.string :slug, null: false

      t.timestamps null: false
    end
    add_index :collections, [:user_id, :slug], unique: true
  end
end
