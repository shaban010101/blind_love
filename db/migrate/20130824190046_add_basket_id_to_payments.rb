class AddBasketIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :basket_id, :integer
  end
end
