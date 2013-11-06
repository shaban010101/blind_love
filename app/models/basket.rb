class Basket < ActiveRecord::Base
  attr_accessible :basket_id, :status, :order_id
  has_many :basket_items, :dependent => :destroy
  has_one :order, :dependent => :destroy
end
