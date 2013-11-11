class Category < ActiveRecord::Base
	extend FriendlyId 
	friendly_id :category_name, use: :slugged
  attr_accessible :category_name, :products_attributes, :slug, :department_id, :category_departments_attributes

  has_many :products
  has_many :category_departments, :dependent => :destroy
  has_many :departments, :through => :category_departments

  validates_presence_of :category_name

  accepts_nested_attributes_for :products
  accepts_nested_attributes_for :category_departments

  scope :department_category, lambda { |department| joins(:department, :products).where("departments.department_name" => department ) }
  scope :category_department, lambda { |department| joins(:category_departments).where("category_departments.department_id" => department)}
end
