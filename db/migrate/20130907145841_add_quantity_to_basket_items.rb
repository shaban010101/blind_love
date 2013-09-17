class AddQuantityToBasketItems < ActiveRecord::Migration
  def change
    add_column :basket_items, :quantity, :integer
  end
end
