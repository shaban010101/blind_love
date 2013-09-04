class OrdersController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create]

  def new
    @order = current_basket.build_order(params[:basket_id]) 
  end

  def create
    @order = current_basket.create_order(params[:payment]) 
    if @order.charge_customer
      redirect_to root_path
      flash[:notice] = "Congrats you've made an order"
    else
       flash[:notice] = "Please try again"
       render "new" 
    end
  end

  def show
    @order = Order.find(params[:id])
  end

end