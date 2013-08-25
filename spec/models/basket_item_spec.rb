require 'spec_helper'

describe BasketItem do
  let(:basket_item) { FactoryGirl.create(:basket_item) }
  let(:product) { FactoryGirl.create(:product) }
  
  it { should belong_to(:basket) }
  it { should belong_to(:product) }
  it { should belong_to(:payment)}

  it "should sum the totals for products in the shopping basket" do
    FactoryGirl.create(:basket_item)
    BasketItem.product_totals.should == "9999"
  end
end
