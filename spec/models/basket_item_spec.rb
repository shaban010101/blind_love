require 'spec_helper'

describe BasketItem do
  let(:product) { FactoryGirl.create(:product) }
  let(:basket) { FactoryGirl.create(:basket)}
  let(:basket_item) { FactoryGirl.create(:basket_item ) }

  it { should belong_to(:basket) }
  it { should belong_to(:product) }
  it { should belong_to(:order)}

  it "should sum the totals for products in the shopping basket" do
    product = FactoryGirl.create(:product)
    basket = FactoryGirl.create(:basket)
    basket_item = FactoryGirl.create(:basket_item, :product_id => product.id, :basket_id => basket.id )
    BasketItem.product_totals(basket.id).should == "9999"
  end
end
