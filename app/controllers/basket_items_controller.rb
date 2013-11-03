class BasketItemsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:create, :destroy, :update]
  def create
    @basket = current_basket
    @basket_item = BasketItem.add_item(params[:basket_items])

    if @basket_item.save
      redirect_to basket_path(@basket)
      flash[:success] = "Product added to your shopping basket"
    else
      flash[:error] = "Product could not be added to your shopping basket"
      redirect_to basket_path(@basket)
    end
  end

  def destroy
    @basket_item = BasketItem.find(params[:id])
    @basket_item.destroy
    if @basket_item.destroy
      flash[:success] = "Product has been removed from your shopping basket"
      redirect_to current_basket
    else
      flash[:error] = "Product couldn't be removed from the shopping basket"
      redirect_to basket_path
    end
  end
end