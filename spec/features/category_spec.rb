require 'spec_helper'

feature 'Category' do
	let(:category) { FactoryGirl.create(:category) }
	let(:product) { FactoryGirl.create(:product) }


	scenario "creation" do
		visit new_admin_category_path
		fill_in "category_category_name", :with => category.category_name
		page.select('Foo', :from => "category_products_products")
		click_button('Save Category')
	end

	scenario "editing" do
		visit edit_admin_category_path(category.slug)
		fill_in "category_category_name", :with => "Baz"
		page.select('Barz', :from => "category_products_products")
		click_button("Update Category")
	end
end