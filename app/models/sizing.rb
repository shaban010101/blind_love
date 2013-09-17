class Sizing < ActiveRecord::Base
  attr_accessible :product_id, :size_id, :quantity

  belongs_to :product
  belongs_to :size
end
