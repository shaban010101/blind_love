class HomePagesController <  ApplicationController
  skip_before_filter :authenticate_user!

  def index
    @products = Product.all
  end
end