require 'spec_helper'

describe Payment do
  subject(:payment) { FactoryGirl.build(:payment) }

  it "should set the total from the value of basket_item totals" do
    basket_item = FactoryGirl.create(:basket_item)
    payment = FactoryGirl.build(:payment)

    BasketItem.product_totals
    payment.product_totals
    payment.save
    payment.total.should == 9999
  end
end
