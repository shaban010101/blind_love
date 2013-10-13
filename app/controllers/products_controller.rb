class ProductsController < ApplicationController
	skip_before_filter :authorize, :only => [:index, :show]

  def index
    @products = Product.search(params)
  end

	def show
	 @product = Product.find(params[:id])
	end
end