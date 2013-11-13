class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def status
    @order = Order.find(params[:id])
    @order.update_attributes(params[:order])
    flash[:success] = "Order status updated"  
  end
end