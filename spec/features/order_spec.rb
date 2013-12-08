require 'spec_helper'

feature "Order" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @order = FactoryGirl.create(:order, :user_id => @user.id)
    login_as(@user, :scope => :user)
  end

  scenario "cancels order" do
    visit user_orders_path(@user)
    click_button("Cancel Order")
    page.has_css?("div.alert.alert-notice", :text => "Order cancelled")
  end

  scenario "can only view own orders and not other users" do
    user_2 = FactoryGirl.create(:user)
    login_as(user_2, :scope => :user)
    visit user_orders_path(@user)
    visit user_path(user_2)
  end
end