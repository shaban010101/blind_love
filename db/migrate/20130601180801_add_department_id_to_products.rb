class AddDepartmentIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :department_id, :integer
  end
end
