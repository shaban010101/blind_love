require 'spec_helper'

describe BasketItem do
  let(:product) { FactoryGirl.create(:product) }
  let(:basket) { FactoryGirl.create(:basket)}
  let(:basket_item) { FactoryGirl.create(:basket_item ) }

  it { should belong_to(:basket) }
  it { should belong_to(:product) }
  it { should belong_to(:order)}
  it { should validate_presence_of(:product_id) }
  it { should validate_presence_of(:size_id) }
  it { should validate_presence_of(:basket_id) }

  it "should sum the totals for products in the shopping basket" do
    basket_item = FactoryGirl.create(:basket_item, :product_id => product.id, :basket_id => basket.id )
    BasketItem.product_totals(basket.id).should == 9999
  end

  it "merge duplicate products" do
    basket_item = FactoryGirl.create(:basket_item, :product_id => product.id, :basket_id => basket.id, :size_id => 1)
    basket_item_two = FactoryGirl.create(:basket_item, :product_id => product.id, :basket_id => basket.id, :size_id => 1)

    BasketItem.add_item(basket_item)
    BasketItem.add_item(basket_item_two)

    BasketItem.all.map {|b| b.quantity }.should == [2] 
  end

  it "not merge non-duplicate products" do
    basket_item_two = FactoryGirl.create(:basket_item, :product_id => product.id, :basket_id => basket.id, :size_id => 3)

    [basket_item, basket_item_two].each do |b|
      BasketItem.add_item(b)
    end

    BasketItem.where(:basket_id => basket.id).map {|b| b.quantity }
    .should == [1] 
  end

  it "sums the product price by the quantity" do
    basket_item = FactoryGirl.create(:basket_item, :quantity => 2)
    basket_item.price_times_quantity
    expect(basket_item.item_price).to eq(19998)
  end
end
