class BasketsController < ActionController::Base
  skip_before_filter :authorize, :only => [:show, :destroy]

  def show
    begin
      @basket = Basket.find(session[:basket_id])
      @basket_items = @basket.basket_items     
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Could not find basket with id of #{@basket.id}"
      redirect_to current_basket
    end
  end

  def destroy
    @basket = Basket.find(session[:basket_id])
    @basket.destroy
    if @basket.destroy
      flash[:notice] = "Basket has been emptied"
      redirect_to root_path
    else
      flash[:notice] = "Basket couldn't be emptied"
      redirect_to basket_path
    end
  end
end