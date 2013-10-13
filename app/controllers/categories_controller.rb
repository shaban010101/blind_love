class CategoriesController < ApplicationController
	skip_before_filter :authorize, :only => [:show, :search]

	def show
    @cat = Category.find(params[:id])
	  # @category = Category.department_category(params[:department])
		@cp = Product.products_category(@cat).pricing(params[:minimum],params[:maximum]).lowest_or_highest(params[:ordering])
    @pr = Product.workout_min_and_max(@cat)
	end

  def search
    # @cat = Category.find(params[:category])
    @cp = Product.search(params)
    # @department = Department.find(params[:department])
  end
end