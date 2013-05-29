class Department < ActiveRecord::Base
	extend FriendlyId 
	friendly_id :department_name, use: :slugged

  attr_accessible :department_name, :slug
  has_many :categories
  has_many :products
  accepts_nested_attributes_for :categories, :products
  DEFAULT_VALUES = ["Mens", "Womens", "Kids"]

  validates_presence_of :department_name
end
