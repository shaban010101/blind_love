class RemovePaymentIdFromBaskets < ActiveRecord::Migration
  def up
    remove_column(:baskets, :payment_id)
  end

  def down
    add_column(:baskets, :payment_id, :integer)
  end
end
