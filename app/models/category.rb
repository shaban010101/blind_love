class Category < ActiveRecord::Base
  attr_accessible :category_name, :department_id, :products_attributes

  has_many :products
  belongs_to :department

  validates_presence_of :category_name
  validates_presence_of :department_id
  accepts_nested_attributes_for :products
end
