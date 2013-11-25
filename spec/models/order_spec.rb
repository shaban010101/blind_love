require 'spec_helper'

describe Order do
  let(:basket) { FactoryGirl.create(:basket) }
  let(:order) { FactoryGirl.create(:order, :basket_id => basket.id) }
  let(:product) { FactoryGirl.create(:product) }
  let(:sizing)  { FactoryGirl.create(:sizing, :quantity => 2, :product_id => product.id) }
  let(:basket_item) { FactoryGirl.create(:basket_item, :basket_id => basket.id, :sizing_id => sizing.id, :product_id => product.id, :quantity => 1) }
  let(:user) { FactoryGirl.create(:user) }
  let(:order) { FactoryGirl.create(:order, :basket_id => basket.id) }

  it { should belong_to(:basket) }
  it { should belong_to(:address) }
  it { should belong_to(:payment) }
  it { should belong_to(:user) }
  it { should have_many(:basket_items)}

  it "works out the total amount" do
    order.send(:totals)
    order.should_receive(:create)
    order.total.should == 9999
  end

  it "retrieves the basket items" do
    basket = FactoryGirl.create(:basket)
    order = FactoryGirl.create(:order, :basket_id => basket.id)
    basket_item = FactoryGirl.create(:basket_item, :basket_id => basket.id)
    order.get_basket_items(basket).should == [basket_item]
  end

  it "deducts the order quantity from the sizings quantity" do
    basket = FactoryGirl.create(:basket)
    order = FactoryGirl.build(:order, :basket_id => basket.id)
    product = FactoryGirl.create(:product)
    sizing = FactoryGirl.create(:sizing, :quantity => 2, :product_id => product.id)
    basket_item = FactoryGirl.create(:basket_item, :basket_id => basket.id, :sizing_id => sizing.id, :product_id => product.id, :quantity => 1)
    order.save
    basket_item.sizing.should_receive(:decrement)
  end

  it "recieves the order id of the order" do
    order_1 = FactoryGirl.build(:order, :basket_id => basket.id)
    basket_item = FactoryGirl.create(:basket_item, :basket_id => basket.id)
    order_1.save
    basket_item.should_receive(:update_attributes)
  end
end
