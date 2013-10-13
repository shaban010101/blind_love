require 'spec_helper'

feature Product do 
  before do
    @product = FactoryGirl.create(:product)
    @category = FactoryGirl.create(:category)
    @department = FactoryGirl.create(:department)
  end

  scenario "search for products" do
    visit category_path(@category.slug)
    fill_in 'query', :with => @product.name
    click_button 'Search'
    page.should have_content(@product.name)
  end
end