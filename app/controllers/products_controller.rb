class ProductsController < ApplicationController
	skip_before_filter :authorize, :only => [:show]

	def show
		@product = Product.find(params[:id])
	end
end