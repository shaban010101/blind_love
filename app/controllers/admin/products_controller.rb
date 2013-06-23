class Admin::ProductsController < ApplicationController
	before_filter :authorize

	def index
		@products = Product.paginate(:page => params[:page], :per_page => 15 )
	end

	def new
		@product = Product.new
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
		@product = Product.update_attributes(params[:id])
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