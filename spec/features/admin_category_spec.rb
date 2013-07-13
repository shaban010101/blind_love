require 'spec_helper'

feature 'Category' do
	context "when logged in" do
		# let
		# let (:attr_cat) do 
		# 	{
		# 		:category_name => "Trousers",
  #   		:slug  => "trousers",
  #   		:products_attributes => {:product_id => 1}
		# 	}
		# end

	  let(:user) { FactoryGirl.create(:user)}
		
		before(:each) do
			@category = FactoryGirl.create(:category)
			# @user = FactoryGirl.create(:user)
			
			visit '/sessions/new'
			fill_in "Username", :with => user.username
			fill_in "Password", :with => user.password
			click_button "Login"
			page.driver.post '/sessions', :username => user.username, :password => user.password	
		end

		scenario "creation" do
			# @category = FactoryGirl.create(:category)
			visit new_admin_category_path
			fill_in "category_category_name", :with => "trousers"
			find(:xpath, "//option[1]").click
			click_button('Save Category')
		end

		scenario "editing" do
			@category = FactoryGirl.create(:category, :products_attributes => [FactoryGirl.attributes_for(:product, :name => "Barz")])
			visit edit_admin_category_path(@category.slug)
			fill_in "category_category_name", :with => "Baz"
			page.select('Barz', :from => "category_products_products")
			click_button("Save Category")
			visit admin_category_path(@category)
	  end

	  scenario "viewing" do
	  	visit admin_categories_path
	  	click_on "Show"
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