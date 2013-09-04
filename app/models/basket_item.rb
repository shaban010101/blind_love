class BasketItem < ActiveRecord::Base
  attr_accessible :basket_id, :product_id, :order_id
  
  belongs_to :product
  belongs_to :basket
  belongs_to :order

  def self.product_totals
    joins(:product).sum("price")
  end
end
