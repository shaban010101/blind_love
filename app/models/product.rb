class Product < ActiveRecord::Base
	extend FriendlyId 
	friendly_id :name, use: :slugged

	attr_accessible :name, :price, :description, :category_id, :slug, :department_id

	validates_presence_of :price
	validates_presence_of :name
	validates_presence_of :description

	belongs_to :category 
	belongs_to :department
end