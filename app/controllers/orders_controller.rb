class OrdersController < ApplicationController
  load_and_authorize_resource
  
  def index
    @order = Order.this_user(current_user)
  end

  def new
    @basket = current_basket.basket_items
    if @basket.empty?
      redirect_to basket_path(current_basket)
    else
      @order = current_basket.build_order(params[:basket_id])
      @order.add_attributes(attributes = {:user_id => current_user.id, :basket_id => current_basket.id })
      @address = Address.this_user(current_user)
      @payment = Payment.only_this_user(current_user)
    end
  end

  def create
   @order = Order.new(params[:order])
   
    if @order.delay.charge_customer(params[:order])
      basket = current_basket
      basket.update_attributes(:status => "Inactive", :order_id => @order)
      redirect_to user_order_path(current_user,@order)
    else
      flash[:notice] = "Please try again"
      render "new"
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def cancel
    Order.update_order(params[:order])
    redirect_to user_orders_path(current_user)
    flash[:notice] = "Order Cancelled"
  end

  def update_basket_item
    @basket_item = BasketItem.update_item(params[:basket_item])
    if BasketItem.update_item(params[:basket_item])
      flash[:succces] = "Basket updated"
      redirect_to new_order_path
    else
      flash[:error] = "Item could not be updated"
      redirect_to new_order_path
    end
  end
end