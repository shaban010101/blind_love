class CategoriesController < ApplicationController
	skip_before_filter :authenticate_user!, :only => [:show, :search]

	def show
    @department = Department.find_by_slug(params[:department_id])
    @cat = Category.find(params[:id])
	 	
    @cp = Product.products_department(@department).products_category(@cat).
      pricing(params[:minimum],params[:maximum]).
        lowest_or_highest(params[:ordering]).sizes(params[:size])

    begin
      @pr = Product.workout_min_and_max(@cat, @department)
    rescue Product::NoProducts
      redirect_to department_path(@department)
      flash[:notice] = "Sorry no products in the category"
    end

    respond_to do |format|
      format.html
      format.js { render :json => @cp }
    end
  end
end