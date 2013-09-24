class CategoriesController < ApplicationController
	skip_before_filter :authorize, :only => [:index, :show, :search]

	def show
		@category = Category.find(params[:id])
		@cp = @category.products
	end

  def search
    @cp = Product.search(params)
  end
end