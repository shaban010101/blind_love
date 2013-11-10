class ChangeStatusToOrders < ActiveRecord::Migration
  def change
    change_column_default(:orders, :status, "Processing")
  end
end
