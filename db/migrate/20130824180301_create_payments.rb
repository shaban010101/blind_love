class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :address_1
      t.string :address_2
      t.integer :card_no
      t.integer :csv
      t.date :start_date
      t.date :exp_date

      t.timestamps
    end
  end
end
