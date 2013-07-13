class DepartmentsController < ApplicationController

	def index
		@department = Department.all
	end

	def show
		@department.products.collect { |p| p.product }
	end

end