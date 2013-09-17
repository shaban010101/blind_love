class RemoveQuantityFromSizes < ActiveRecord::Migration
  def up
    remove_column(:sizes, :quantity)
    add_column(:sizings, :quantity, :integer)
  end

  def down
    add_column(:sizes, :quantity, :integer)
    remove_column(:sizings, :quantity)
  end
end
