class Department < ActiveRecord::Base
	extend FriendlyId 
	friendly_id :department_name, use: :slugged

  attr_accessible :department_name, :slug, :products_attributes, :categories_attributes
  has_many :categories
  has_many :products
  accepts_nested_attributes_for :categories, :products

  validates_presence_of :department_name

  # Elastic Search Integration
  # def self.search(params)
  # 	tire.search(load: true) do
  # 		query { string params[:query] } if params[:query].present?
  # 	end
  # end

  # def to_indexed_json
  #   # to_json(methods: [:products])
  #   {
  #     :products => products.map { |p| {:_id => p.id} } 
  #   }
  # end
end
