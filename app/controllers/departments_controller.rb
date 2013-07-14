class DepartmentsController < ApplicationController
	skip_before_filter :authorize, :only => [:show]

	def show
		@department = Department.find(params[:id])
		@dep_cat = @department.categories.find(:all)
		begin 
			@department = Department.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			render 'public/404', status: 404
		end
	end
end