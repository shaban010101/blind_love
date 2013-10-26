require 'spec_helper'

feature Product do 
  before do
    @product = FactoryGirl.create(:product)
  end

  scenario "search for products" do
    visit searches_path
    fill_in 'query', :with => @product.name
    click_button 'Search'
    page.should have_content(@product.name)
  end
end