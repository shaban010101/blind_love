require 'spec_helper'

describe Order do
  before(:each) do
    @order = FactoryGirl.build(:order)
    @basket_item = FactoryGirl.create(:basket_item)
    @basket = FactoryGirl.create(:basket)
  end

  it "should give a validation error when year is not in the correct format" do
    @order = FactoryGirl.build(:order, :year => 201)
    @order.should_not be_valid
  end

  it "should give a validation error when the month is not in the correct format" do
    @order.month = 213
    @order.should_not be_valid
  end

  it "should give a validation error when the month is blank" do
    @order.month = ""
    @order.should_not be_valid
  end

  it "should delete the basket when making an order", :skipping => true do
    @order.create
    @basket.stauts.should = "Inactive"
  end
end
