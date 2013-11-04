class AddressesController < ApplicationController
  def index
    @addresses = Address.this_user(params[:user_id])
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(params[:address])
    if @address.save
      redirect_to user_addresses_path(current_user)
      flash[:success] = "New address created"
    else
      render "new"
      flash[:error] = "Error address could not be saved"
    end 
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update_attributes(params[:address])
      redirect_to user_addresses_path
      flash[:success] = "Address updated"
    else
      render "new"
      flash[:error] = "Error address could not be updated"
    end 
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to user_addresses_path, :success => "Address deleted"
  end
end