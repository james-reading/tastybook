class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, null: true, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.text :body, null: false, default: ''

      t.timestamps null: false
    end
  end
end
