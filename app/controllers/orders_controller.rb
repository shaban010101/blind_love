class OrdersController < ApplicationController

  def index
    @order = Order.this_user(current_user)
  end

  def new
    @basket = current_basket.basket_items
    if @basket.empty?
      redirect_to basket_path(current_basket)
    else 
      @order = current_basket.build_order(params[:basket_id])
      @address = Address.this_user(current_user)
      @payment = Payment.only_this_user(current_user)
    end
  end

  def create
   @order = Order.new(params[:order])
    if @order.charge_customer(params[:order])
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
    Order.cancel_order(params[:id])
    redirect_to user_orders_path(current_user)
    flash[:notice] = "Order Cancelled"
  end
end