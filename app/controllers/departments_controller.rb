class DepartmentsController < ApplicationController
	skip_before_filter :authorize, :only => [:index,:show]
	
  def index
    @departments = Department.all
    @products = Product.all
  end
	
  def show
		@department = Department.find(params[:id])
		@dep_cat = @department.products.find(:all)
	end
end