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

    def current_basket
      if session[:basket_id]
        basket.find(session[:basket_id])
      else 
        basket = Basket.create
        session[:basket_id] = basket.id
      end
    end
end
