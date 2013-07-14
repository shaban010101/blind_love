require 'spec_helper'

feature Department do

	background do
		user = FactoryGirl.create(:user)
		visit '/sessions/new'
		fill_in "Username", :with => user.username
		fill_in "Password", :with => user.password
		click_button "Login"
		page.driver.post '/sessions', :username => user.username, :password => user.password	
	end

	scenario "Editing and selecting multiple products" do
		@department = FactoryGirl.create(:department)
		visit edit_admin_department_path(@department.slug)
		save_and_open_page
		find(:xpath, '//option[1]').click
		find(:xpath, '/option[2]').click
		find(:xpath, '/option[3]').click
		click_button("Save")   
	end

	scenario "denied entry when not logged in" do
	end
end