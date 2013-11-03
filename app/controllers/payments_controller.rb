class PaymentsController < ApplicationController 
  def index
   @payment = Payment.only_this_user(current_user)
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(params[:payment])
    if @payment.create_payment_method
      redirect_to user_payments_path(current_user)
      flash[:notice] = "Card successfully saved"
    else
      render "new"
    end
  end


  def edit
    @payment = Payment.find(params[:id])
  end


  def update
    @payment = Payment.find(params[:id])
    if @payment.update_payment_method
      redirect_to user_payments_path(current_user)
      flash[:notice] = "Card successfully updated"
    else
      render "edit"
    end 
  end
end