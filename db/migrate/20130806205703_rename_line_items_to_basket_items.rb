class RenameLineItemsToBasketItems < ActiveRecord::Migration
  def change
    rename_table :line_items, :basket_items
  end
end
