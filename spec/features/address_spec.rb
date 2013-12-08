require "spec_helper"

feature "Address"  do

  before(:each) do
    @user  = FactoryGirl.create(:user)
    @address = FactoryGirl.create(:address, :user_id => @user.id)
    visit new_user_session_path
    login_as(@user, :scope => :user)
  end

  scenario "can create a new Address" do
    visit new_user_address_path(@user.id)
    fill_in "Address 1", :with => @address.address_1
    fill_in "Address 2", :with => @address.address_2
    fill_in "City", :with => @address.city
    fill_in "Post code", :with => @address.post_code
    click_button "Create Address"
    page.has_css?("div.alert.alert-success", :text => "New address created")
  end

  scenario "cannot create a new Address due to an error" do
    visit new_user_address_path(@user.id)
    fill_in "Address 1", :with => ""
    fill_in "Address 2", :with => @address.address_2
    fill_in "City", :with => @address.city
    fill_in "Post code", :with => @address.post_code
    click_button "Create Address"
    page.has_css?("div.alert.alert-error", :text => "Error address could not be saved")
  end

  scenario "can edit an existing Address " do
    visit user_addresses_path(@user.id)
    click_link("Edit")
    visit edit_user_address_path(@user.id, @address.id)
    fill_in "Address 1", :with => @address.address_1
    fill_in "Address 2", :with => @address.address_2
    fill_in "City", :with => @address.city
    fill_in "Post code", :with => @address.post_code
    click_button "Update Address"
    page.has_css?("div.alert.alert-success", :text => "Address updated")
  end

  scenario "gets an error when trying to save an edit to an existing Address " do
    visit user_addresses_path(@user.id)
    click_on("Edit")
    visit edit_user_address_path(@user.id, @address.id)
    fill_in "Address 1", :with => @address.address_1
    fill_in "Address 2", :with => @address.address_2
    fill_in "City", :with => @address.city
    fill_in "Post code", :with => @address.post_code
    click_button "Update Address"
    page.has_css?("div.alert.alert-error", :text => "Error address could not be updated")
  end
end