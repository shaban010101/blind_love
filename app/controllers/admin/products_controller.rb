class Admin::ProductsController < ApplicationController
	
	def index
		@products = Product.all
	end

	def new
		@products = Product.new
	end

	def show
		@product = Product.find(params[:id])
	end

	def create
		@product = Product.new(params[:product])
		if @product.save
			flash[:notice] = "Product succesfully created"
			redirect_to admin_products_path
		else
			flash.now[:error] = "Could not save the product"
			render "new"
		end
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.update_attributes(params[id])
		if @product.update
			flash[:notice] = "Product Succesfully updated"
		else
			flash.now[:error] = "Product could not be edited"
			render "edit"
		end
	end

	def destroy
		@product = Product.find(params[:id])
	end
end