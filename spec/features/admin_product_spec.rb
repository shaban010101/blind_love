require	'spec_helper'

feature 'Product' do
	context "when logged in" do
		before(:each) do
			@product = FactoryGirl.create(:product)
			@user = FactoryGirl.create(:user)
			visit '/sessions/new'
			fill_in "Username", :with => @user.username
			fill_in "Password", :with => @user.password
			click_button "Login"
			page.driver.post '/sessions', :username => @user.username, :password => @user.password	
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

	  scenario 'deleting' do
	  	visit '/admin/products'
	  	find(:xpath, "//tr[2]/td[5]/a").click
	  	visit '/admin/products'
	  	page.should have_content("The products has gone")
	  end
	 end

	context "when not logged in" do
	  scenario 'denied entry when not signed in' do
	  	visit '/admin/products'
	  	page.should have_content("Please log in")
	  	visit '/sessions/new'
	 	end
	end	
end