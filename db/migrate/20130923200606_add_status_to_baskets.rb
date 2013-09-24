class AddStatusToBaskets < ActiveRecord::Migration
  def change
    add_column :baskets, :status, :string
  end
end
