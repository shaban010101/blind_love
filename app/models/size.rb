class Size < ActiveRecord::Base
  attr_accessible :size_name
  has_many :sizings
  has_many :products, :through => :sizings
end
