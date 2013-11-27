class Product < ActiveRecord::Base
	extend FriendlyId

	friendly_id :name, use: :slugged
	has_attached_file :image

	attr_accessible :ranges, :name, :price, :description, :slug, :image, :image_file_name, :sizings_attributes, :category_department_id
  attr_accessor :ranges

  belongs_to :category_department
	has_many :sizings, :dependent => :destroy
	has_many :sizes, :through => :sizings
	has_many :basket_items
  before_save :downcase_name

  validates_presence_of :price
  validates :price, :numericality => true
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :description
  validates_attachment_presence :image
  validates :category_department_id, :presence => true

  accepts_nested_attributes_for :sizes
  accepts_nested_attributes_for :sizings, reject_if: :all_blank

  scope :search, lambda { |params| where("name LIKE ?", "%#{params[:query]}%" ) }
  scope :products_category, lambda { |category| joins(:category_department).where("category_departments.category_id" => category) }
  scope :products_department, lambda { |department| joins(:category_department).where("category_departments.department_id" => department) }
  scope :products_category_department, lambda { |category_department| joins(:category_department).where(:category_department_id => category_department) }
  scope :lowest_or_highest, lambda { |ordering| order("price #{ordering}") if ordering.present? }
  scope :pricing, lambda { |min,max| where(:price => (min)..(max)) if min.present? && max.present? }
  scope :sizes, lambda { |size| joins(:sizings).where("sizings.size_id" => size)  if size.present? }

  def downcase_name
    name.downcase!
  end
  
  def self.workout_min_and_max(category, department)
    min = self.products_category(category).products_department(department).minimum(:price)
    max = self.products_category(category).products_department(department).maximum(:price)

    min = (min / 100) * 100
    max = max.round(-2)

    ranges = (min..max).select {|m| m % 100 == 0  }
  end
end