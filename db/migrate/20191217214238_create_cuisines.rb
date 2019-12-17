class CreateCuisines < ActiveRecord::Migration[6.0]
  def change
    create_table :cuisines do |t|
      t.string :name, null: false, default: ''

      t.timestamps null: false
    end
  end
end
