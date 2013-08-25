class BasketsController < ActionController::Base
  skip_before_filter :authorize, :only => [:show]
  def show
    # begin
      @basket = Basket.find(params[:id])
      @basket_items = @basket.basket_items
    # rescue ActiveRecord::RecordNotFound
    #   flash[:notice] = "Could not find basket with id of #{@basket.id}"
    #   redirect_to products_path
    # end
  end
end