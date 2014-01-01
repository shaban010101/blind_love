module ApplicationHelper

  def department
    @department = Department.all
  end
  
  def categories(department)
    @department = Department.find_by_department_name(department)
    @dc = @department.category_departments
  end
end
