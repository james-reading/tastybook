class AddCourseToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :course, :string
  end
end
