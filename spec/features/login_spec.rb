require 'spec_helper'

feature "Session" do 

	before do
		@user = FactoryGirl.create(:user)
	end 

	scenario "can login in the website page" do
		visit '/users/sign_in'
		fill_in "Email", :with => @user.username
		fill_in "Password", :with => @user.password
		click_button "Sign in"
		page.driver.post '/users/sign_in', :username => @user.username, :password => @user.password	
		visit("/users/#{@user.id}")
	end

	scenario "invalid details entered" do
		visit '/users/sign_in'
		fill_in "Email", :with => ""
		fill_in "Password", :with => ""
		click_button "Sign in"
		page.driver.post '/users/sign_in', :username => "", :password => ""	
		visit '/users/sign_in'
	end

	context "Logged into site"
		scenario "can logout of the website" do		
			visit '/users/sign_in'
			fill_in "Email", :with => @user.username
			fill_in "Password", :with => @user.password
			click_button "Sign in"
			page.driver.post '/users/sign_in', :username => @user.username, :password => @user.password		
			visit("/users/#{@user.id}")
			click_link("Log Out")
			visit '/users/sign_in'
		end
end

