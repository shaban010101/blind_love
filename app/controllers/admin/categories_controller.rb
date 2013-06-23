class Admin::CategoriesController < ApplicationController
	def new
		@category = Category.new
		@products = @category.products.build
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
		@products = @category.products.build
	end

	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(params[:category])
			redirect_to admin_category_path
		else
			flash.now[:error] = "Could not  update this category"
			render "edit"
		end
	end
end