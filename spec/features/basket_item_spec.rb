require 'spec_helper'

feature "BasketItem" do
  before(:each) do
    @department = FactoryGirl.create(:department)
    @category = FactoryGirl.create(:category)
    @size = FactoryGirl.create(:size)
    @product =  FactoryGirl.create(:product, :department_id => @department.id, :category_id => @category.id)
    @sizing = FactoryGirl.create(:sizing, :size_id => @size.id, :product_id => @product.id)
    @basket = FactoryGirl.create(:basket)
    @basket_item = FactoryGirl.create(:basket_item, :basket_id => @basket.id)
  end

  scenario "able to add items to the shopping basket" do
    visit department_category_product_path(@department.slug,@category.slug,@product.slug)
    select("Small", :from => "basket_items_sizing_id")
    click_button "Add to Basket"
    visit basket_path(@basket.id)
    page.has_xpath?("//div[2]/strong")
  end

  scenario "able to delete items from the shopping basket" do
    visit department_category_product_path(@department.slug,@category.slug,@product.slug)
    select("Small", :from => "basket_items_sizing_id")
    click_button "Add to Basket"
    visit basket_path(@basket.id)
    click_button "Remove"
    page.should have_content("Product has been removed from your shopping basket")
  end

  scenario "displays product totals" do
    visit department_category_product_path(@department.slug,@category.slug,@product.slug)
    click_button "Add to Basket"
    visit basket_path(@basket.id)
    page.has_xpath?("//p[2]")
  end

  scenario "updates an item quantity in the basket" do
    visit department_category_product_path(@department.slug,@category.slug,@product.slug)
    click_button "Add to Basket"
    visit basket_path(@basket.id)
    fill_in "basket_item_quantity", :with => 4
    click_button "Update"
    page.has_css?("input#basket_item_quantity.input-mini", :text => 4) 
  end

  scenario "attempting to go to a cart which does not belong to the user", :skipping => true do
    @basket = FactoryGirl.create(:basket)
    @basket2 = FactoryGirl.create(:basket)
    visit basket_path(@basket2.id)
  end
end