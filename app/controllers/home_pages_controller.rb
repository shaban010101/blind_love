class HomePagesController <  ApplicationController
  skip_before_filter :authenticate_user!

  def index
    @products = Product.paginate(:page => params[:page], :per_page => 6)
  end
end