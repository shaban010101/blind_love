class Admin::CategoriesController < ApplicationController
	def new
		@categories = Category.new
	end

	def index
		@categories = Category.all
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

	def edit 
		@category = Category.find(params[:id])
		@products = Product.all
	end
end