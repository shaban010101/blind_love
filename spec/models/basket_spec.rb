require 'spec_helper'

describe Basket do

  before(:each) do
    @basket = FactoryGirl.create(:basket)
    order = double("order")
  end

  it { should have_one(:order) }

  it "should set the status to inactive" do
    @basket.update_attributes(:status => "Inactive", :order_id => 1)
    @basket.status.should == "Inactive"
    @basket.order_id.should == 1
  end
end
