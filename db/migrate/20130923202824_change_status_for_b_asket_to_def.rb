class ChangeStatusForBAsketToDef < ActiveRecord::Migration
  def up
    change_column_default(:baskets, :status, "Active")
  end

  def down
    change_column_default(:baskets, :status, "nil")
  end
end
