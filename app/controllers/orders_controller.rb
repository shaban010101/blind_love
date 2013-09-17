class OrdersController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create, :shipping, :payment, :review]

  def create
    @order = current_basket.create_order(params[:order])
    if @order.save
      redirect_to payment_order_path(@order)
    else
      flash[:notice] = "Please try again"
      redirect_to shipping_order_path
    end
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def shipping
    @order = current_basket.build_order(params[:basket_id]) 
  end

  def payment
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
      redirect_to review_order_path
    else
      flash[:notice] = "The order could not be made"
      render payment_order_path
    end
  end

  def review
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
      redirect_to order_path(@order)
    else
      flash[:notice] = "The order could not be made"
      render review_order_path
    end
  end
end