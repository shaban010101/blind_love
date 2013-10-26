class Admin::CategoriesController < ApplicationController

	def new
		@category = Category.new
		@category.category_departments.build
	end

	def index
		@categories = Category.paginate(:page => params[:page], :per_page => 15 )
	end

	def create
		@category = Category.new(params[:category])
		if @category.save
			redirect_to admin_products_path
		else
			flash.now[:error] = "Could not save the category"
			render "new"
		end
	end

	def show
		@category = Category.find(params[:id])
	end

	def edit 
		@category = Category.find(params[:id])
    @category.products.build
    @category.category_departments.build
	end

	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(params[:category])
			redirect_to admin_category_path(@category)
			flash.now[:notice] = "Category Updated"
		else
			flash.now[:error] = "Could not  update this category"
			render "edit"
		end
	end

	def destroy
    @category = Category.find_by_slug(params[:id])
    if @category.present?
    	@category.destroy
    end
    flash[:notice] = "The category has been deleted"
    redirect_to admin_categories_path
  end
end