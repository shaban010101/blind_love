class AddPaymentIdToBasketItem < ActiveRecord::Migration
  def up
    add_column :basket_items, :payment_id, :integer
  end
end
