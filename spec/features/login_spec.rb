require 'spec_helper'

feature "Session" do 
	let(:user) { FactoryGirl.create(:user) }

	scenario "can login in the website page" do
		login_into_account
		visit("/users/#{user.id}")
	end

	scenario "invalid details entered" do
		visit '/users/sign_in'
		fill_in "Email", :with => ""
		fill_in "Password", :with => ""
		click_button "Sign in"
		page.driver.post '/users/sign_in', :username => "", :password => ""	
		visit '/users/sign_in'
	end

	scenario '/users/sign_in' do
		visit '/users/sign_in'
		fill_in "Email", :with => user.email
		fill_in "Password", :with => user.password
		click_button "Sign in"
		visit("/users/#{user.id}")
		click_link("Log Out")
		visit login_path
	end
end

