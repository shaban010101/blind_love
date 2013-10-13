class RemoveDepartmentFromProducts < ActiveRecord::Migration
  def up
    remove_column(:products, :department)
    add_column(:products, :department_id, :integer)
  end

  def down
    add_column(:products, :department, :string)
    remove_column(:products, :department_id)
  end
end
