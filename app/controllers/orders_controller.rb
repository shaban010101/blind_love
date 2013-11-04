class OrdersController < ApplicationController

  def new 
    @order = current_basket.build_order(params[:basket_id])
    @address = Address.this_user(current_user)
    @payment = Payment.only_this_user(current_user)
  end

  def create
    @order = current_basket.create_order(params[:order])
    if @order.charge_customer
      basket = @order.basket
      basket.update_attributes(:status => "Inactive", :order_id => @order)
      redirect_to order_path(@order)
    else
      flash[:notice] = "Please try again"
      render "new"
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end