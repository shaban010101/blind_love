class CategoriesController < ActionController::Base
	skip_before_filter :authorize, :only => [:index, :show]

	def index

	end

	def show
		@category = Category.find(params[:id])
		@cp = @category.products.find(:all)
	end

end