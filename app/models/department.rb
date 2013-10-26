class Department < ActiveRecord::Base
  extend FriendlyId 
  friendly_id :department_name, use: :slugged 
  attr_accessible :department_name, :slug
  has_many :products
  has_many :category_departments
  has_many :categories, :through => :category_departments
end