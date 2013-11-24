class AmendCategoryDepartmentIdToProducts < ActiveRecord::Migration
  def up
    remove_column(:products, :category_department_id)
    add_column(:products, :category_department_id, :integer)
  end
end
