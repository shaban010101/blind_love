class ChangeSizeName < ActiveRecord::Migration
  def change
    rename_column(:sizes,:size, :size_name)
  end
end
