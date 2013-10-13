require 'spec_helper'

describe Order do
  before(:each) do
    @basket_item = FactoryGirl.create(:basket_item)
    @basket = FactoryGirl.create(:basket)
    @order = FactoryGirl.build(:order, :basket_id => @basket.id)
  end

  it "should give a validation error when year is not a number" do
    @order.year = "jfjfjf"
    @order.should_not be_valid
  end

  it "should give a validation error when month is not a number" do
    @order.month = "jfjfjf"
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

  it "should give a validation error when the month is blank" do
    @order.year = ""
    @order.should_not be_valid
  end

  it "should delete the basket when making an order" do
    # @order.basket.should_recieve(:update_attributes).with(:status => "Inactive", :order_id => @order.id)
    # @basket.status.should == "Inactive"
    # @basket.order_id.should == @order.id
  end
end
