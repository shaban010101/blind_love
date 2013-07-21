require 'spec_helper'

feature "Department" do
	
	background do
		@user = FactoryGirl.create(:user)			
		visit '/sessions/new'
		fill_in "Username", :with => @user.username
		fill_in "Password", :with => @user.password
		click_button "Login"
		page.driver.post '/sessions', :username => @user.username, :password => @user.password	
	end

	scenario "viewing the products a department has" do
		@department = FactoryGirl.create(:department)
		visit '/departments/mens/'
		page.should have_content("Foo")
	end

	# scenario "clicking on populated categories for the department" do
	# 	@department = FactoryGirl.create(:department)
	# 	visit '/departments/mens/'
	# 	fill_in "Search", :with => @product.name
	# 	page.should have_content("Foo")
	# end 
end