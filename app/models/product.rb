class Product < ActiveRecord::Base
	extend FriendlyId

	friendly_id :name, use: :slugged
	has_attached_file :image

	attr_accessible :name, :price, :description, :category_id, :slug, :image, :image_file_name, :department

	validates_presence_of :price
	validates_presence_of :department
	validates :price, :numericality => true
	validates_presence_of :name
	validates_uniqueness_of :name
	validates_presence_of :description
	validates_attachment_presence :image

	belongs_to :category
	has_many :sizings
	has_many :sizes, :through => :sizings
	has_many :basket_items

  scope :search, lambda { |params| where("name LIKE ?", "%#{params[:query]}%" ) }

  scope :mens_clothing, where(:department => "Mens")
  # scope :mens_category, lambda do  |category_name| 
  # 	joins(:category).where("category.category_name =?", category_name) 
  # end

  def to_param
  	category
  end
end