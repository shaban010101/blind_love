class RemoveDepartmentIdFromCategories < ActiveRecord::Migration
  def up
    remove_column(:categories, :department_id)
  end

  def down
    add_column(:categories, :department_id, :integer)
  end
end
