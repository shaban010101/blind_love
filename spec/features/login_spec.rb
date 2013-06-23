require 'spec_helper'

feature "Session" do 

	before do
		@user = FactoryGirl.create(:user)
	end 

	scenario "can login in the website page" do
		visit '/sessions/new'
		fill_in "Username", :with => @user.username
		fill_in "Password", :with => @user.password
		click_button "Login"
		page.driver.post '/sessions', :username => @user.username, :password => @user.password		
		visit("/users/#{@user.id}")
	end

	scenario "invalid details entered" do
		visit '/sessions/new/'
		fill_in "Username", :with => ""
		fill_in "Password", :with => ""
		click_button "Login"
		page.driver.post '/sessions', :username => "", :password => ""		
		visit '/sessions/new'
		page.should have_content("Your email or password is invalid")
	end
	
	context "Logged into site"
		scenario "can logout of the website" do		
			visit '/sessions/new'	
			fill_in "Username", :with => @user.username
			fill_in "Password", :with => @user.password
			click_button "Login"
			page.driver.post '/sessions', :username => @user.username, :password => @user.password		
			visit("/users/#{@user.id}")
			click_link("Log Out")
			visit '/sessions/new'
			# page.should have_content("Logged out yay!")
		end

		scenario "gets a message when the user is already logged in" do 
			visit '/sessions/new/'
			fill_in "Username", :with => @user.username
			fill_in "Password", :with => @user.password
			click_button "Login"
			login_post
			visit("/users/#{@user.id}")		
			visit '/sessions/new/'
			page.should have_content("You silly lemon your already logged in!")
		end	
end

