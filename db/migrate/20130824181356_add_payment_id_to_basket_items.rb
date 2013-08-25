class AddPaymentIdToBasketItems < ActiveRecord::Migration
  def change
    add_column :basket_items, :payment_id, :integer
  end
end
