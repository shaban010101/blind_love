require	'spec_helper'

feature 'Product' do
	let(:product) { FactoryGirl.create(:product) }

	scenario "creation" do
		visit '/admin/products/new'
		fill_in "Name", :with => product.name 
		fill_in "Description", :with => product.description 
		fill_in "Price", :with => product.price
		attach_file "Image", Rails.root.join('spec', 'fixtures', 'images', 'boom.jpg')
		click_button "Save Product"
		page.should have_content "Product succefully created"
  end

  scenario 'editing' do
  	visit '/admin/products'
  	click_link(:xpath, '//html/body/a[2]')
  	visit '/admin/products/1'
  	fill_in "Name", :with => "Foo1" 
		fill_in "Description", :with => "Bar1" 
		fill_in "Price", :with => "1000"
		attach_file("Image", '/Users/shabankarumba/Pictures/IMG_0001.PNG')
		page.content.should_be("Product Succefully updated")
  end	
end