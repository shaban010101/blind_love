class AddItemPriceToBasketItems < ActiveRecord::Migration
  def change
    add_column :basket_items, :item_price, :integer
  end
end
