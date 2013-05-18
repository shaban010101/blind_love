class Department < ActiveRecord::Base
  attr_accessible :department_name
  has_many :categories
  has_many :products
  accepts_nested_attributes_for :categories, :products
  DEFAULT_VALUES = ["Mens", "Womens", "Kids"]

  validates_presence_of :department_name
end
