require 'spec_helper'

feature "Category" do
  before(:each) do
    @category = FactoryGirl.create(:category)
    @department = FactoryGirl.create(:department)
    @category_department = FactoryGirl.create(:category_department, :category_id => @category.id)
    @product = FactoryGirl.create(:product, :category_department_id => @category_department.id)
  end

  it "displays products for this department" do
    visit department_category_path(@department,@category)
    find(:xpath, "//ul[1]/p[2]/a")
    .should have_content(@product_one)
  end
end