class Product < ActiveRecord::Base
	extend FriendlyId
	include Tire::Model::Search
	include Tire::Model::Callbacks

	friendly_id :name, use: :slugged
	has_attached_file :image

	attr_accessible :name, :price, :description, :category_id, :slug, :image, :department_id, :image_file_name

	validates_presence_of :price
	validates :price, :numericality => true
	validates_presence_of :name
	validates_uniqueness_of :name
	validates_presence_of :description
	validates_attachment_presence :image

	belongs_to :category
	belongs_to :department
	has_many :sizings
	has_many :sizes, :through => :sizings
	has_many :line_items

  def self.search(params)
  	tire.search(load: true) do
  		query { string params[:query] } if params[:query].present?
  	end
  end
end