class Payment < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :card_no, :csv, :exp_date, :first_name, :last_name, :start_date, :title, :basket_id, :total
  
  has_many :basket_items

  before_save :product_totals

  def product_totals
    self.total = basket_items.product_totals
  end
end
