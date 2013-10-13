class CategoryDepartment < ActiveRecord::Base
  attr_accessible :category_id, :department_id
  belongs_to :department
  belongs_to :category
end
