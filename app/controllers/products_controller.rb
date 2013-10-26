class ProductsController < ApplicationController
	skip_before_filter :authenticate_user!, :only => [:index, :show]

  def index
    @products = Product.search(params)
  end

	def show
	 @product = Product.find(params[:id])
   @sizing = @product.sizings
	end
end