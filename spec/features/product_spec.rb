require 'spec_helper'

feature "Product" do
  
  background do
    @user = FactoryGirl.create(:user)
    @product = FactoryGirl.create(:product)
    @category = FactoryGirl.create(:category)
    visit '/sessions/new'
    fill_in "Username", :with => @user.username
    fill_in "Password", :with => @user.password
    click_button "Login"
    page.driver.post '/sessions', :username => @user.username, :password => @user.password  
  end

  scenario "viewing the products a category has" do
    visit category_path(@category.slug)
    page.has_xpath?("//p[2]/a")
  end
end