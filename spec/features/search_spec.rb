require 'spec_helper'

feature Department do 
  before do
    @product = FactoryGirl.create(:product)
  end

  scenario "search for products" do
    visit "/departments/"
    fill_in 'query', :with => @product.name
    click_button 'Search'
    page.should have_content(@product.name)
  end
end