class CategoryDepartment < ActiveRecord::Base
  attr_accessible :category_id, :department_id
  belongs_to :department
  belongs_to :category
  has_many :products

  scope :category_department, lambda { |category| joins(:category).where(:category_id => category) }
  scope :department_category, lambda { |department| joins(:department).where(:department_id => department) }

  def self.category_department_list
    cat_dep = self.all
    cat_dep_hash = Hash.new
    cat_dep.each do |category_department|
      cat_dep_hash.merge!("#{category_department.department.department_name.capitalize}-#{category_department.category.category_name.capitalize }" => category_department.id)
    end
    cat_dep_hash
  end
end
