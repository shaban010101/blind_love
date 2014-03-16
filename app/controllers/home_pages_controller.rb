class HomePagesController <  ApplicationController
  skip_before_filter :authenticate_user!

  def index
    @products = Product.paginate(:page => params[:page], :per_page => 6)

    page = ab_test("homepage_test", "index", "index_b")
    render page
    finished("homepage_test")
  end
end