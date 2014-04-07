require 'spec_helper'

feature Product do 
  before do
    @product = FactoryGirl.create(:product)
  end

  scenario "search for products" do
    visit searches_path
    fill_in 'query', :with => @product.name
    within("//ul[2]/li[2]/div/div[2]") do
      find(:css, "input.alert.button.expand")
    end
    page.should have_content(@product.name.capitalize)
  end
end