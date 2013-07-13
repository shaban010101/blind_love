class Admin::DepartmentsController < ApplicationController
	before_filter :authorize 
	def edit 
		@department = Department.find(params[:id])
		@products = @products.department.build(parmas[:products_attributes])
	end 
end