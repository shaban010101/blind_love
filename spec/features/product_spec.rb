require 'spec_helper'

feature "Product" do
  before(:each) do
   @category = FactoryGirl.create(:category)
   @department = FactoryGirl.create(:department)
   @category_department = FactoryGirl.create(:category_department, :category_id => @category.id, :department_id => @department.id)
   @product = FactoryGirl.create(:product, :category_department_id => @category_department.id)
  end

  scenario "viewing the products a category has" do
    visit department_category_path(@department.slug, @category.slug)
    page.has_xpath?("//p[2]/a")
  end

  scenario "switiching ordering of products" do
    product_one = FactoryGirl.create(:product, :price => 800, :category_department_id => @category_department.id)
    visit department_category_path(@department.slug, @category.slug)
    select('Ascending', :from => "ordering")
    click_button "Filter"
    find(:xpath, "//ul[1]/p[2]/a")
    .should have_content(product_one.name)
  end

  scenario "filter products by cost" do
    visit department_category_path(@department.slug, @category.slug)
    select("9900", from: "minimum")
    select("10000", from: "maximum")
    click_button "Filter"
    page.should have_content("foo")
  end

  scenario "filter products does not show any products when no products within the range" do
    visit department_category_path(@department.slug, @category.slug)
    select("9900", from: "minimum")
    select("9900", from: "maximum")
    click_button "Filter"
    page.should have_content("Oh no products")
  end
end