class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :product_id
      t.string :category_name

      t.timestamps
    end
  end
end
