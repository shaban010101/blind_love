class Product < ActiveRecord::Base
	include FriendlyId 
	friendly_id :name

	attr_accessible :name, :price, :description, :category_id, :slug

	validates_presence_of :price
	validates_presence_of :name
	validates_presence_of :description

	belongs_to :category 
	belongs_to :department
end