class Basket < ActiveRecord::Base
  attr_accessible :order_id, :basket_id, :status
  has_many :basket_items, :dependent => :destroy
  has_one :order
end
