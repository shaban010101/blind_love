class AddUserIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :user_id, :integer
    remove_column :orders, :stripe_token
  end
end
