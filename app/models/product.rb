class Product < ActiveRecord::Base
	extend FriendlyId 
	friendly_id :name, use: :slugged
	has_attached_file :image

	attr_accessible :name, :price, :description, :category_id, :slug, :image

	validates_presence_of :price
	validates_presence_of :name
	validates_presence_of :description

	belongs_to :category
	belongs_to :department
	# accepts_nested_attributes_for :departments

end