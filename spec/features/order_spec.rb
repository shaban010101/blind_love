require 'spec_helper'

feature "Order" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @order = FactoryGirl.create(:order, :user_id => @user.id)
    login_as(@user, :scope => :user)
  end

  context "ordering products" do
    before(:each) do
      @product = FactoryGirl.create(:product)
      @basket = FactoryGirl.create(:basket)
      @basket_item = FactoryGirl.create(:basket_item, :basket_id => @basket.id, :product_id => @product.id)
      @size = FactoryGirl.create(:size)
      @sizing = FactoryGirl.create(:sizing, :product_id => @product.id, :size_id => @size.id)
      visit product_path(@product.slug)
      select("Small", :from => "basket_items_sizing_id")
      click_button "Add to Basket"
      visit basket_path(@basket.id)
      page.has_xpath?("//div[2]/strong")
    end

    scenario "order basket items" do
      visit new_order_path
      
    end
  end

  scenario "cancels order" do
    visit user_orders_path(@user)
    save_and_open_page
    click_button("Cancel Order")
    page.has_css?("div.alert.alert-notice", :text => "Order cancelled")
  end

  scenario "can only view own orders and not other users" do
    user_2 = FactoryGirl.create(:user)
    login_as(user_2, :scope => :user)
    visit user_orders_path(user)
    visit user_path(user_2)
  end
end