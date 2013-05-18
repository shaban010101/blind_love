class AddDepartmentIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :department_id, :integer
  end
end
