class CreateDepartmentsProductsJoinTable < ActiveRecord::Migration
  def change
  	create_table :departments_products, :id => false do |t|
  		t.integer :department_id
  		t.integer :product_id
  	end
  end
end
