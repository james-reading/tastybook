class CreateSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.references :recipe, null: false, foreign_key: true
      t.text :description
      t.integer :position

      t.timestamps null: false
    end
  end
end
