require 'spec_helper'

describe Order do
  subject(:order) { FactoryGirl.build(:order) }

  before(:each) do
    basket_item = FactoryGirl.create(:basket_item)
    basket = FactoryGirl.create(:basket)
  end

  it "should set the total from the value of basket_item totals", :skipping => true do
    BasketItem.product_totals
    order.product_totals
    order.save
    order.total.should == 9999
  end

  it "should give a validation error when year is not in the correct format" do
    order.year = 201
    order.should_not be_valid
  end

  it "should give a validation error when the month is not in the correct format" do
    order.month = 213
    order.should_not be_valid
  end

  it "should give a validation error when the month is blank" do
    order.month = ""
    order.should_not be_valid
  end

  it "should not allow past years to be entered" do
    order.year = 2012
    order.should_not be_valid
  end

  it "should give a validation error when month and year are in the past" do
    order.year = 2012
    order.month = 8
    order.should_not be_valid
  end

  it "should delete the basket when making an order", :skipping => true do
    order.create
    order.basket.should = nil
  end
end
