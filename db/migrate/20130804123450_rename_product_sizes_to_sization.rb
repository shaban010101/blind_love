class RenameProductSizesToSization < ActiveRecord::Migration
  def change
    rename_table(:product_sizes, :sizings)
  end
end
