class DropDepartmentIdFromProducts < ActiveRecord::Migration
  def change
  	remove_column :products, :department_id
  end
end
