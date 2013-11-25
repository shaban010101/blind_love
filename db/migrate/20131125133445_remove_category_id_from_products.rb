class RemoveCategoryIdFromProducts < ActiveRecord::Migration
  def change
    remove_column(:products, :category_id)
    remove_column(:products, :department_id)
  end
end
