class Admin::OrdersController < ApplicationController
  load_and_authorize_resource
  
  def index
    @orders = Order.processing
  end

  def update
    Order.update_order(params[:order])
    redirect_to admin_orders_path
    flash[:success] = "Order status updated"  
  end
end