require 'spec_helper'

describe Basket, :skipping => true do
  @basket = FactoryGirl.create(:basket)
  @order = FactoryGirl.create(:order)

  it { should have_one(:order) }

  it "should set the status to inactive", :skipping => true do
    @basket.set_status_to_inactive
    @basket.status.should == "Inactive"
  end
end
