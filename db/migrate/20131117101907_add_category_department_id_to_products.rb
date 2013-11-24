class AddCategoryDepartmentIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :category_department_id, :string
    add_column :products, :integer, :string
  end
end
