require 'spec_helper'

feature "Product" do
  let(:product) { FactoryGirl.create(:product) }
  let(:category) { FactoryGirl.create(:category) }

  scenario "viewing the products a category has" do
    visit category_path(category.slug)
    page.has_xpath?("//p[2]/a")
  end

  scenario "switiching ordering of products" do
    product = FactoryGirl.create(:product, name: "Sanchev")
    visit category_path(category.slug)
    select('Ascending', :from => "ordering")
    click_button "Filter"
    find(:xpath, "//ul[1]/p[2]/a")
    .should have_content('Sanchev')
  end

  scenario "filter products by cost" do
    visit category_path(category.slug)
    select("", from: "minimum")
    select("", from: "maximum")
    click_button "Filter"
  end
end