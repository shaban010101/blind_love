require	'spec_helper'

feature 'Product' do
	let(:product) { FactoryGirl.create(:product) }

	scenario "Create a product" do
		visit '/admin/products/new'
		fill_in "Name", :with => product.name 
		fill_in "Description", :with => product.description 
		fill_in "Price", :with => product.price
		attach_file("Image", '/Users/shabankarumba/Pictures/IMG_0001.PNG')
		page.content.should_be("")
  end	
end