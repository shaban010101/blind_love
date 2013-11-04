require 'spec_helper'

describe Order do
  let(:order) { FactoryGirl.create(:order) }

  it { should belong_to(:basket) }
  it { should belong_to(:address) }
  it { should belong_to(:payment) }
  it { should belong_to(:user) }
  it { should have_many(:basket_items)}

  it "works out the total amount" do
    product = FactoryGirl.create(:product)
    basket = FactoryGirl.create(:basket)
    basket_item = FactoryGirl.create(:basket_item, :product_id => product.id, :basket_id => basket.id)
    order = FactoryGirl.build(:order, :basket_id => basket.id)
    order.product_totals
    order.total.should == 9999
  end
end
