class PaymentsController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create]

  def new
    @payment = current_basket.build_payment(params[:basket_id]) 
  end

  def create
    @payment = current_basket.create_payment(params[:payment]) 
    if @payment.save
      redirect_to root_path
      flash[:notice] = "Congrats you've made an order"
    else
       flash[:notice] = "Please try again"
       render "new" 
    end
  end
end