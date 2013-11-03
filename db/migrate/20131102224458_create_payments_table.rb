class CreatePaymentsTable < ActiveRecord::Migration
  def up
    create_table :payments do |t|
      t.string :stripe
      t.timestamps
    end
  end

  def down
    drop_table(:payments)
  end
end
