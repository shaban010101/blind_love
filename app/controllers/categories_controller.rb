class CategoriesController < ApplicationController
	skip_before_filter :authenticate_user!, :only => [:show, :search]

	def show
    @department = Department.find_by_slug(params[:department_id])
    @cat = Category.find(params[:id])
    # @category_department = @cat.category_departments
	 	
    @cp = Product.products_department(@department).products_category(@cat).
      pricing(params[:minimum],params[:maximum]).
        lowest_or_highest(params[:ordering]).sizes(params[:size])

    @pr = Product.workout_min_and_max(@cat, @department)
  end
end