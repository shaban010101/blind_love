require 'spec_helper'

feature Product do 
  before do
    @product = FactoryGirl.create(:product)
  end

  scenario "search for products" do
    visit searches_path
    fill_in 'query', :with => @product.name
    find(:xpath, "//li[2]/div/div[2]/input").click
    page.should have_content(@product.name)
  end
end