class ProductsController < ApplicationController
	skip_before_filter :authorize, :only => [:index, :show, :mens]

  def index
    @products = Product.search(params)
  end

	def show
		@product = Product.find(params[:id])
	end

  def mens
    @product = Product.mens_clothing
  end
end