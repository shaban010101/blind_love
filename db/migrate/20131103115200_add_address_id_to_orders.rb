class AddAddressIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :address_id, :integer
    add_column :orders, :payment_id, :integer
  end
end
