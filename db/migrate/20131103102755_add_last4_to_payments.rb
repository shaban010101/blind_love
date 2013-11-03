class AddLast4ToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :last4, :integer
    add_column :payments, :type, :string
    add_column :payments, :exp_month, :integer
    add_column :payments, :exp_year, :integer
  end
end
