class Category < ActiveRecord::Base
	extend FriendlyId 
	friendly_id :category_name, use: :slugged
  attr_accessible :category_name, :products_attributes, :slug

  has_many :products
  belongs_to :department

  validates_presence_of :category_name
  accepts_nested_attributes_for :products


end
