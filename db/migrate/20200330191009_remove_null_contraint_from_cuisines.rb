class RemoveNullContraintFromCuisines < ActiveRecord::Migration[6.0]
  def up
    change_column_null :recipes, :cuisine_id, true
  end

  def down
    change_column_null :recipes, :cuisine_id, false
  end
end
