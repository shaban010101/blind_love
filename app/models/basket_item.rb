class BasketItem < ActiveRecord::Base
  attr_accessible :basket_id, :product_id, :order_id
  
  belongs_to :product
  belongs_to :basket
  belongs_to :order

  def self.product_totals(basket_id)
    joins(:basket, :product).where(:basket_id => basket_id ).sum(:price)
  end
end
