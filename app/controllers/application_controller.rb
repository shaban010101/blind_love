class ApplicationController < ActionController::Base
	before_filter :authenticate_user!
  protect_from_forgery

  def after_sign_in_path_for(user)
    admin_index_path
  end

  def get_basket
    @current_basket ||= Basket.find(session[:basket_id]) if session[:basket_id]
  end

  helper_method :current_basket 
  
  def current_basket
    Basket.find(session[:basket_id])
  rescue ActiveRecord::RecordNotFound 
    basket = Basket.create
    session[:basket_id] = basket.id
    basket
  end
end
