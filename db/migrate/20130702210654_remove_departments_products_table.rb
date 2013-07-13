class RemoveDepartmentsProductsTable < ActiveRecord::Migration
  def change
  	add_column :products, :department_id, :integer
  	drop_table :departments_products
  end
end
