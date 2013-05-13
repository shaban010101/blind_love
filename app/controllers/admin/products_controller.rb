class Admin::ProductsController < ApplicationController
	
	def index
		@products = Product.all
	end

	def new
		@products = Product.new
	end

	def create
		@product = Product.new(params[:product])
		if @product.save
			redirect_to admin_products_path
		else
			flash.now[:error] = "Could not save the product"
			render "new"
		end
	end
end