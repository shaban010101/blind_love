require 'spec_helper'

feature 'Category', %q{
	As an admin
	To be able to manage categories
	I want to be able to go to the category admin section 
	and be able to create, edit and delete categories 	
} do
	context "when logged in" do

		before(:each) do
			@category = FactoryGirl.create(:category)
			@user = FactoryGirl.create(:user)
			@department = FactoryGirl.create(:department)
			visit new_user_session_path
			fill_in "Email", :with => @user.email 
			fill_in "Password", :with => @user.password
			click_button "Sign in"
	  	page.should have_content("Signed in successfully.")
		end

		scenario "creating a category" do
			visit new_admin_category_path
			fill_in "category[category_name]", :with => "trousers"
			find(:xpath, "//option[1]", :match => :first).click
			click_button('Create Category')
		end

		scenario "editing a category" do
			@category = FactoryGirl.create(:category, :products_attributes => [ FactoryGirl.attributes_for(:product, :name => "Barz")])
			visit edit_admin_category_path(@category.slug)
			fill_in "category_category_name", :with => "Baz"
			find(:xpath, "//option[1]").click
			click_button("Update Category")
			visit admin_category_path(@category)
	  end

	  scenario "viewing a category" do
	  	visit admin_categories_path
	  	find(:xpath, "//p[1]/a[1]").click
	  	visit admin_category_path(@category)
	  end

	  scenario "deleting a category" do
	  	visit admin_categories_path
	  	find(:xpath, "//td[4]/a").click
	  	page.has_xpath?("//div[2]/p")
	  end
	end
end