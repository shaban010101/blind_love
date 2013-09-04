class RemoveColumnsFromPayment < ActiveRecord::Migration
  def up
    remove_column(:payments, :csv)
    remove_column(:payments, :card_no)
    remove_column(:payments, :exp_date)
    remove_column(:payments, :start_date)
  end

  def down
    add_column(:payments, :csv, :integer)
    add_column(:payments, :card_no, :integer)
    add_column(:payments, :exp_date, :date)
    add_column(:payments, :start_date, :date)
  end
end
