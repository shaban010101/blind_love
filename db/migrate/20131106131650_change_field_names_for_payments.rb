class ChangeFieldNamesForPayments < ActiveRecord::Migration
  def up
    rename_column(:payments, :last4, :last_four)
    rename_column(:payments, :exp_month, :expiry_month)
    rename_column(:payments, :exp_year, :expiry_year)
    rename_column(:payments, :type, :card_type)
  end

  def down
    rename_column(:payments, :last_four, :last4)
    rename_column(:payments, :expiry_month, :exp_month)
    rename_column(:payments, :expiry_year, :exp_year)
    rename_column(:payments, :card_type, :type)
  end
end
