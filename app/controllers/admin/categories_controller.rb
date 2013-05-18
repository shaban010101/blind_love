class Admin::Categories < ApplicationController
	def new
		@category = Category.new
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
end