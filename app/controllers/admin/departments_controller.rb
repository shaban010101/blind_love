class Admin::DepartmentsController < ApplicationController 
	def edit 
		@department = Department.find(params[:id])
		@products = @products.department.build
	end 
end