class Basket < ActiveRecord::Base
  has_many :basket_items, :dependent => :destroy
end
