class BasketsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:show, :destroy]

  def show
    begin
      @basket = current_basket
      if @basket.status == "Inactive"
        basket = Basket.create
        session[:basket_id] = basket.id
        basket
        redirect_to current_basket
      else
        @basket_items = current_basket.basket_items
      end
    rescue ActiveRecord::RecordNotFound
      render 'public/404', status: 404
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

  def update_basket_item
    @basket_item = BasketItem.update_item(params[:basket_item])
    if BasketItem.update_item(params[:basket_item])
      flash[:succces] = "Basket updated"
      redirect_to basket_path
    else
      flash[:error] = "Item could not be updated"
      redirect_to basket_path
    end
  end
end