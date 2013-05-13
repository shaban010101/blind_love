class SessionsController < ApplicationController
	def new 
	end

	def create 
		if user && user.authenticate(params[:password])
			session[:user_id] = user.user.id
			redirect_to root_url, :notice => "Logged In!"
		else
			flash.now.alert = "Invalid email or Password supplied"
			render login_path
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to login_path, :notice => "Logged out"
	end
end