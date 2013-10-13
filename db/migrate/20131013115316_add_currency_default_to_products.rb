class AddCurrencyDefaultToProducts < ActiveRecord::Migration
  def change
    change_column(:products, :currency, :string, :default => "gbp")
  end
end
