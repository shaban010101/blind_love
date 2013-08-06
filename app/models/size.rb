class Size < ActiveRecord::Base
  attr_accessible :quantity, :size
  has_many :sizings
  has_many :products, :through => :sizings
end
