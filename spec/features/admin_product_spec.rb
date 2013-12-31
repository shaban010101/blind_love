require	'spec_helper'

feature 'Product' do
	context "when logged in" do
		before(:each) do
		  @product = FactoryGirl.create(:product)
			@user = FactoryGirl.create(:user, :role => "admin")
			@size = FactoryGirl.create(:size)
			@sizing = FactoryGirl.create(:sizing)
			visit new_user_session_path
			login_as(@user, :scope => :user)
		end

		scenario "creation" do
			visit '/admin/products/new'
			fill_in "Name", :with => "Foo" 
			fill_in "Description", :with => "Baz" 
			fill_in "Price", :with => 1000
			attach_file("Image", Rails.root + 'spec/fixtures/images/ruby.png')
			select("Mens-Trousers", :from => "product_category_department_id")
			find(:xpath, "//option[1]",  :match => :first ).click
			fill_in "product_sizings_attributes_0_quantity", :with => 10
			click_button "Create Product"
			page.has_xpath?("/html/body/div[2]/p")
	  end

	  scenario 'editing' do
	  	visit '/admin/products'
	  	find(:xpath, "//tr/td[6]/a").click
	  	fill_in "Name", :with => "Foo1" 
			fill_in "Description", :with => "Bar1" 
			fill_in "Price", :with => "1000"
			attach_file "Image", Rails.root.join('spec', 'fixtures', 'images', 'boom.jpg')
			select("Mens-Trousers", :from => "product_category_department_id")
			find(:xpath, "//option[1]",  :match => :first ).click
			fill_in "product_sizings_attributes_0_quantity", :with => 10
			page.has_xpath?("//div[2]/p")
	  end

	  scenario 'deleting' do
	  	visit '/admin/products'
	  	find(:xpath, "//tr/td[7]/a").click
	  	visit '/admin/products'
	  	page.has_xpath?("//div[2]/p")
	  end
	 end
end