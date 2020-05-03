class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :likeable, null: false, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
