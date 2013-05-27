class Category < ActiveRecord::Base
  attr_accessible :category_name, :products_attributes

  has_many :products
  belongs_to :department

  validates_presence_of :category_name
  accepts_nested_attributes_for :products

  # def category_assigned
  	
  # end

end
