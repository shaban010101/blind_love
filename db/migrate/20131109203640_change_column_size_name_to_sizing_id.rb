class ChangeColumnSizeNameToSizingId < ActiveRecord::Migration
  def up
    rename_column(:basket_items, :size_id, :sizing_id)
  end

  def down
    rename_column(:basket_items, :sizing_id, :size_id)
  end
end
