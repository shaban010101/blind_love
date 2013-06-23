require 'spec_helper'

feature 'Admin' do
	let(:user) {FactoryGirl.create(:user)}

	scenario "should login into the dashboard" do
		visit '/sessions/new'
		fill_in "Username", :with => user.username 
		fill_in "Password", :with => user.password
		click_button "Login"
		page.driver.post '/sessions', :username => user.username, :password => user.password
		visit '/admin'
		#  page.should have_content("Logged In")
	end

	scenario "No entry unless logged in" do
		visit '/admin'
		page.should have_content("Please log in")
		visit '/sessions/new'
	end
end