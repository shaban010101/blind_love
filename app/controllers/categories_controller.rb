class CategoriesController < ActionController::Base
	skip_before_filter :authorize, :only => [:index, :show]

	def show
		@category = Category.find(params[:id])
		@cp = @category.products
	end

  def search
    @products = Product.search(params)
  end
end