require 'spec_helper'

feature "BasketItem" do

  scenario "able to add items to the shopping basket" do
    @product = FactoryGirl.create(:product)
    @basket = FactoryGirl.create(:basket)
    # @basket_item = FactoryGirl.create(:basket_item)
    visit product_path(@product.slug)
    click_button "Add to Basket"
    visit basket_path(@basket.id)
    page.has_xpath?("//p")
  end

  scenario "able to delete items from the shopping basket" do
    @product = FactoryGirl.create(:product)
    @basket = FactoryGirl.create(:basket)
    # @basket_item = FactoryGirl.create(:basket_item)
    visit product_path(@product.slug)
    click_button "Add to Basket"
    visit basket_path(@basket.id)
    click_on "Remove"
    page.should have_content("Product has been removed from your shopping basket")
  end
end