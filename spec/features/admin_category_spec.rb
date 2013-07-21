require 'spec_helper'

feature 'Category', %q{
	As an admin
	To be able to manage categories
	I want to be able to go to the category admin section 
	and be able to create, edit and delete categories 	
} do
	context "when logged in" do
		
		before(:each) do
			@user = FactoryGirl.create(:user)
			visit '/sessions/new'
			fill_in "Username", :with => @user.username
			fill_in "Password", :with => @user.password
			click_button "Login"
			page.driver.post '/sessions', :username => @user.username, :password => @user.password	
		end

		scenario "creating a category" do
			@category = FactoryGirl.create(:category)
			visit new_admin_category_path
			fill_in "category_category_name", :with => "trousers"
			find(:xpath, "//option[1]").click
			click_button('Save Category')
		end

		scenario "editing a category" do
			@category = FactoryGirl.create(:category, :products_attributes => [FactoryGirl.attributes_for(:product, :name => "Barz")])
			visit edit_admin_category_path(@category.slug)
			fill_in "category_category_name", :with => "Baz"
			page.select('Barz', :from => "category_products_products")
			click_button("Save Category")
			visit admin_category_path(@category)
	  end

	  scenario "viewing a category" do
	  	@category = FactoryGirl.create(:category)
	  	visit admin_categories_path
	  	find(:xpath, "//p[1]/a[1]").click
	  	visit admin_category_path(@category.slug)
	  end
	end

	context "when not logged in" do
		scenario "denied entry when not logged in" do
			visit admin_categories_path
			page.should  have_content("Please log in")
			visit new_session_path
		end
	end
end