class BasketItem < ActiveRecord::Base
  attr_accessible :basket_id, :product_id
  
  belongs_to :product
  belongs_to :basket
end
