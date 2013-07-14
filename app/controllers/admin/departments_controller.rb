class Admin::DepartmentsController < ApplicationController

	def edit 
		@department = Department.find(params[:id])
		@products = @department.products.build(params[:products_attributes])
		@products_department = @department.products.find(:all)
	end

	def update
		@department = Department.find(params[:id])
		if @department.update_attributes(params[:department])
			redirect_to admin_department_path(@department)
			flash.now[:notice] = "Department Updated"
		else
			flash.now[:notice] = "Could not update this department"
			render "edit"
		end
	end
end