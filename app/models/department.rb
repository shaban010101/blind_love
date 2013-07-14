class Department < ActiveRecord::Base
	extend FriendlyId 
	friendly_id :department_name, use: :slugged

  attr_accessible :department_name, :slug, :products_attributes, :categories_attributes
  has_many :categories
  has_many :products
  accepts_nested_attributes_for :categories, :products

  validates_presence_of :department_name
end
