require 'spec_helper'

feature "Order" do
  
  before(:each) do
    @order = FactoryGirl.create(:order)
  end

  scenario "add basket items to the checkout" do
    visit new_order_path(@order)
    page.select('Mr', :from => "order_title")
    fill_in "First name", :with => @order.first_name
    fill_in "Last name", :with => @order.last_name
    fill_in "Address 1", :with => @order.address_1
    fill_in "Address 2", :with => @order.address_2
    fill_in "order_number", :with => 4545454545456757
    fill_in "order_cvc", :with => 222
    page.select('April', :from => "date_month") 
    page.select('2013', :from => "date_year")
    click_button "Order"
    visit order_path(@order)
  end
end