class RenamePaymentsToOrders < ActiveRecord::Migration
  def up
    rename_table(:payments, :orders)
  end

  def down
    rename_table(:orders, :payments)
  end
end
