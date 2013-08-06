class CreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.string :size
      t.integer :quantity

      t.timestamps
    end
  end
end
