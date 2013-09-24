class AddOrderIdToBaskets < ActiveRecord::Migration
  def change
    add_column :baskets, :order_id, :integer
  end
end
