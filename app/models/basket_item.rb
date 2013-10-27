class BasketItem < ActiveRecord::Base
  attr_accessible :basket_id, :product_id, :order_id, :quantity, :size_id
  
  belongs_to :product
  belongs_to :basket
  belongs_to :order
  belongs_to :size

  def self.product_totals(basket_id)
    joins(:basket, :product).where(:basket_id => basket_id).sum("price")
  end
end
