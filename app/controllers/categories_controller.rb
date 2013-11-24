class CategoriesController < ApplicationController
	skip_before_filter :authenticate_user!, :only => [:show, :search]

	def show
    @cat = Category.find(params[:id])
    @category_department = CategoryDepartment.category_department(@cat)
		@cp = Product.products_category_department(@category_department).pricing(params[:minimum],params[:maximum]).lowest_or_highest(params[:ordering]).sizes(params[:size])
    @pr = Product.workout_min_and_max(@category_department)
  end
end