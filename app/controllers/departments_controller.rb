class DepartmentsController < ApplicationController
	skip_before_filter :authorize, :only => [:show]

	def show
		@department = Department.find(params[:id])
		@dep_cat = @department.categories.find(:all)
	end
end