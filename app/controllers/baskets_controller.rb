class BasketsController < ApplicationController
  skip_before_filter :authorize, :only => [:show, :destroy]

  def show
    begin
      if status == "Active"
        @basket = Basket.find(session[:basket_id])
        @basket_items = @basket.basket_items
      else
        render 'public/404', status: 404
      end
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