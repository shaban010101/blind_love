class PaymentsController < ApplicationController 
  def index
   @payment = Payment.only_this_user(current_user)
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.create_payment_method(params[:payment])
    if @payment == false
      render "new"
    else
      redirect_to user_payments_path(current_user)
      flash[:notice] = "Card successfully saved"
    end
  end

  def destroy
    @payment = Payment.find
    @payment.destroy
    flash[:notice] = "Card deleted"
  end
end