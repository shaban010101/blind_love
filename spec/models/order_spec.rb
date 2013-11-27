require 'spec_helper'

describe Order do
  before(:each) do
    @basket = FactoryGirl.create(:basket)
    @product = FactoryGirl.create(:product)
    @sizing = FactoryGirl.create(:sizing, :quantity => 2, :product_id => @product.id)
    @basket_item = FactoryGirl.create(:basket_item, :basket_id => @basket.id, :sizing_id => @sizing.id, :product_id => @product.id, :quantity => 1)
    @user = FactoryGirl.create(:user)
    @order = FactoryGirl.create(:order, :basket_id => @basket.id)
  end

  it { should belong_to(:basket) }
  it { should belong_to(:address) }
  it { should belong_to(:payment) }
  it { should belong_to(:user) }
  it { should have_many(:basket_items)}

  it "works out the total amount" do
    @order = FactoryGirl.build(:order, :basket_id => @basket.id )
    @order.save
    @order.total.should == 9999
  end

  it "retrieves the basket items" do
    @order.get_basket_items(@basket).should == [@basket_item]
  end

  it "deducts the order quantity from the sizings quantity" do
    @order = FactoryGirl.create(:order, :basket_id => @basket.id)
    @order.save 
    b = @order.basket_items
    @basket.basket_items.sizing.should == 2
  end

  it "recieves the order id of the order" do
    @order = FactoryGirl.create(:order, :basket_id => @basket.id)
    @order.save
    @order.basket_items.map {|b| b.order_id }
    .should == [@order.id]
  end
end
