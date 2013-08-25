class RemovePaymentIdFromBasketItems < ActiveRecord::Migration
  def up
    remove_column(:basket_items, :payment_id)
    add_column(:baskets, :payment_id , :integer)
  end

  def down
    add_column(:basket_items, :payment_id)
    remove_column(:baskets, :payment_id)
  end
end
