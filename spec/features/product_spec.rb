require	'spec_helper'

feature 'Product' do

	before(:each) do
		@product = FactoryGirl.create(:product)
	end

	scenario "creation" do
		visit '/admin/products/new'
		fill_in "Name", :with => "Foo" 
		fill_in "Description", :with => "Baz" 
		fill_in "Price", :with => 1000
		attach_file "Image", Rails.root.join('spec', 'fixtures', 'images', 'boom.jpg')
		click_button "Save Product"
		page.has_xpath?("/html/body/div[2]/p")
  end

  scenario 'editing' do
  	visit '/admin/products'
  	find(:xpath, "//tr[2]/td[4]/a").click
  	visit '/admin/products/foo/edit'
  	fill_in "Name", :with => "Foo1" 
		fill_in "Description", :with => "Bar1" 
		fill_in "Price", :with => "1000"
		attach_file "Image", Rails.root.join('spec', 'fixtures', 'images', 'boom.jpg')
		page.has_xpath?("//div[2]/p")
  end

  scenario 'denied entry when not signed in' do
  	visit '/admin/products'
  	page.should have_content("Please log in")
  	visit '/sessions/new'
 	end	
end