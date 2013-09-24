class ApplicationController < ActionController::Base
	before_filter :authorize
  protect_from_forgery

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def authorize
		redirect_to login_path, :notice => "Please log in" if current_user.nil?
	end

  private
  helper_method :current_basket 
    def current_basket
      @current_basket ||= Basket.find(session[:basket_id]) if session[:basket_id]
    rescue ActiveRecord::RecordNotFound 
      basket = Basket.create
      session[:basket_id] = basket.id
      basket
    end
end
