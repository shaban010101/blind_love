class AddSizeIdToBasketItems < ActiveRecord::Migration
  def change
    add_column :basket_items, :size_id, :integer
  end
end
