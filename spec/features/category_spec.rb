require 'spec_helper'

feature "Category" do
  before(:each) do
    @category = FactoryGirl.create(:category)
    @department = FactoryGirl.create(:department)
    @category_department = FactoryGirl.create(:category_department, :category_id => @category.id, :department_id => @department.id)
    @product = FactoryGirl.create(:product, :category_department_id => @category_department.id)
  end

  scenario "displays products for this department" do
    visit department_category_path(@department,@category)
    find(:xpath, "//li[1]/p[2]/a")
    .should have_content(@product.name.capitalize)
  end

  scenario "when no products exisit for this category redirect back to the department of the product" do
    @product = FactoryGirl.create(:product)
    visit department_category_path(@department,@category)
    visit department_path(@department.slug)
  end
end