require 'spec_helper'

describe Order do
  subject(:order) { FactoryGirl.build(:order) }

  it "should set the total from the value of basket_item totals" do
    basket_item = FactoryGirl.create(:basket_item)
    order = FactoryGirl.build(:order)

    BasketItem.product_totals
    order.product_totals
    order.save
    order.total.should == 9999
  end
end
