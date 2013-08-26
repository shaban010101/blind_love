class RemoveDepartmentIdFromProductsAndCategories < ActiveRecord::Migration
  def up
    remove_column(:categories,:department_id)
    remove_column(:products,:department_id)
  end

  def down
    add_column(:categories,:department_id)
    add_column(:products,:department_id)
  end
end
