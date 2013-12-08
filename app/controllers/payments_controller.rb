class PaymentsController < ApplicationController
  load_and_authorize_resource
   
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
    @payment = Payment.find(params[:id])
    @payment.destroy
    redirect_to user_payments_path(current_user)
    flash[:notice] = "Card deleted"
  end
end