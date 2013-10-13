class Category < ActiveRecord::Base
	extend FriendlyId 
	friendly_id :category_name, use: :slugged
  attr_accessible :category_name, :products_attributes, :slug, :department_id, :products, :departments

  has_many :products
  has_many :category_departments
  has_many :departments, :through => :category_departments

  validates_presence_of :category_name
  accepts_nested_attributes_for :products
  accepts_nested_attributes_for :departments

  scope :department_category, lambda {|department| joins(:department, :products).where("departments.department_name" => department ) }
  # scope :category_department, joins(:category_departments).where(:category => :department)
end
