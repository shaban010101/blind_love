require 'spec_helper'

feature "Department" do
  before(:each) do
    @department = FactoryGirl.create(:department)
    @category_department = FactoryGirl.create(:category_department, :department_id => @department.id)
    @product = FactoryGirl.create(:product, :category_department_id => @category_department.id)
  end

  it "displays products for this department" do
    visit department_path(@department)
    find(:xpath, "//li[1]/p[2]/a")
    .should have_content(@product.name)
  end
end