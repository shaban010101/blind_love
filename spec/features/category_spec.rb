require 'spec_helper'

feature 'Category' do

	# before(:each) do
	# end

	scenario "creation" do
		@category = FactoryGirl.create(:category)
		visit new_admin_category_path
		fill_in "category_category_name", :with => "trousers"
		page.select('Foo', :from => "category_products_products")
		click_button('Save Category')
	end

	scenario "editing" do
		@category = FactoryGirl.create(:category, :products_attributes => [FactoryGirl.attributes_for(:product, :name => "Barz")])
		visit edit_admin_category_path(@category.slug)
		fill_in "category_category_name", :with => "Baz"
		page.select('Barz', :from => "category_products_products")
		click_button("Save Category")
		page.driver.submit '/admin/products/#{@category.slug}', :category_name => @category.category_name, :products_attributes => @category.products_attributes
	end

	scenario "denied entry when not logged in" do
		visit admin_index_path
		page.should  have_content("Please log in")
		visit new_session_path
	end
end