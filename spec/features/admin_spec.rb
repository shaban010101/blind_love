require 'spec_helper'

feature 'Admin' do
	before(:each) do
		@user = FactoryGirl.create(:user)
	end

	scenario "should login into the dashboard" do
		visit new_user_session_path
		fill_in "Email", :with => @user.email 
		fill_in "Password", :with => @user.password
		click_button "Sign in"
	  page.should have_content("Signed in successfully.")
	end

	context "not logged in" do
		scenario "Invalid email or password." do
			visit '/admin'
			fill_in "Email", :with => "fhfhf" 
			fill_in "Password", :with => @user.password
			click_button "Sign in"
			page.should have_content("Invalid email or password.")
			visit '/users/sign_in'
		end
	end
end