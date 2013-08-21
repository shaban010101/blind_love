require 'spec_helper'

feature "CheckOut" do
  scenario "add basket items to the checkout" do
    visit checkout_path(@checkout.id)
    fill_in "First Name", :with => @checkout.first_name
    fill_in "Last Name", :with => @checkout.last_name
    fill_in "House number and Street", :with => @checkout.address_1
    fill_in "City/Town", :with => @checkout.address_2
    fill_in "Card Number", :with => @checkout.card_no
    fill_in "CSV", :with => @checkout.CSV
    fill_in "Start Date", :with => @checkout.start_date
    fill_in "End Date", :with => @checkout.end_date
    click_button "Make Order"
    page.should have_content("Thanks we are now processing your order")
  end
end