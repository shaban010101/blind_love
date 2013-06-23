class SessionsController < ApplicationController
	def create 
		user = User.find_by_username(params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to admin_index_path, :notice => "Logged In!"
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