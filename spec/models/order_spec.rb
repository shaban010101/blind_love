require 'spec_helper'

describe Order do
  let(:order) { FactoryGirl.create(:order) }

  it { should belong_to(:basket) }
  it { should belong_to(:address) }
  it { should belong_to(:payment) }
  it { should belong_to(:user) }
  it { should have_many(:basket_items)}

  it "works out the total amount" do
    user = FactoryGirl.create(:user)
    payment = FactoryGirl.create(:payment)
    product = FactoryGirl.create(:product)
    basket = FactoryGirl.create(:basket)
    basket_item = FactoryGirl.create(:basket_item, :product_id => product.id, :basket_id => basket.id)
    order = FactoryGirl.create(:order, :basket_id => basket.id, :user_id => user.id, :payment_id => payment.id )
    # order.product_totals
    # order.total.should == 9999
  end

  it "saves the stripe_id" do
    user = FactoryGirl.create(:user)
    payment = FactoryGirl.create(:payment)
    order = FactoryGirl.create(:order, :user_id => user.id, :payment_id => payment.id )
    order.save
    order.stripe_id == "cchhcch"
  end

  it "checks a user has an address before proceding", :skipping => true do
    payment = FactoryGirl.create(:payment, :user_id => "")
    user = FactoryGirl.create(:user)
    order = FactoryGirl.create(:order, :user_id => user.id)
    o = Order.check_payment(user.id)
    expect(o.payment_id).to eq(["Please add a payment method"])
  end
end
