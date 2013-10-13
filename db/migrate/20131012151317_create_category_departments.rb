class CreateCategoryDepartments < ActiveRecord::Migration
  def change
    create_table :category_departments do |t|
      t.integer :category_id
      t.integer :department_id

      t.timestamps
    end
  end
end
