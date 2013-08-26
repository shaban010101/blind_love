class DropTableDepartments < ActiveRecord::Migration
  def up
    drop_table(:departments)
  end

  def down
    create_table :departments_products, :id => false do |t|
      t.integer :department_id
      t.integer :product_id
    end
  end
end
