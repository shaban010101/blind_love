class RemoveAttributesFromOrder < ActiveRecord::Migration
  def up
    remove_column(:orders, :title)
    remove_column(:orders, :first_name)
    remove_column(:orders, :last_name)
    remove_column(:orders, :address_1)
    remove_column(:orders, :address_2)
  end

  def down
    add_column(:orders, :title, :string)
    add_column(:orders, :first_name, :string)
    add_column(:orders, :last_name, :string)
    add_column(:orders, :address_1, :string)
    add_column(:orders, :address_2, :string)
  end
end