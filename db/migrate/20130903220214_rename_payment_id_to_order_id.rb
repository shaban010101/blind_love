class RenamePaymentIdToOrderId < ActiveRecord::Migration
  def up
    rename_column(:basket_items, :payment_id, :order_id)
  end

  def down
    rename_column(:basket_items, :order_id, :payment_id)
  end
end
