require 'spec_helper'

describe Order do
  let(:order)  { FactoryGirl.create(:order) }

  it { should belong_to(:basket) }
  it { should belong_to(:address) }
  it { should belong_to(:payment) }
  it { should belong_to(:user) }
  it { should have_many(:basket_items)}

  it "works out the total amount" do
    basket = create(:basket)
    basket_item = create(:basket_item, :basket_id => basket.id)
    order = create(:order, :basket_id => basket.id)
    order.save
    order.total.should == 9999
  end

  it "retrieves the basket items" do
    basket = create(:basket)
    basket_item = create(:basket_item, :basket_id => basket.id)
    order = create(:order, :basket_id => basket.id)
    order.get_basket_items(basket).should == [basket_item]
  end

  it "deducts the order quantity from the sizings quantity" do
    basket = FactoryGirl.create(:basket)
    product = FactoryGirl.create(:product)
    sizing = FactoryGirl.create(:sizing, :product_id => product.id, :quantity => 2)
    basket_item = FactoryGirl.create(:basket_item, :basket_id => basket.id, :sizing_id => 1, :quantity => 1)
    order = FactoryGirl.create(:order, :basket_id => basket.id)
    order.save
  end

  it "recieves the order id of the order" do
    basket = create(:basket)
    basket_item = create(:basket_item, :basket_id => basket.id)
    order = FactoryGirl.create(:order, :basket_id => basket.id)
    order.save
    order.basket_items.map {|b| b.order_id }
    .should == [order.id]
  end

  it "returns orders which have a status of cancelled" do
    order_cancelled = create(:order, :status => "Cancelled")
    Order.cancelled.should == [order_cancelled]
  end

  it "returns orders which have a status of dispatched" do
    order_dispatched = create(:order, :status => "Dispatched")
    Order.dispatched.should == [order_dispatched]
  end

  it "returns orders which have a status of processing" do
    Order.processing.should == [order]
  end

  it "adds attributes to the order object" do
    basket = FactoryGirl.create(:basket)
    order.add_attributes(attributes = {:basket_id => basket.id })
    order.basket.id.should == basket.id
  end

  context "creation and updating" do
    before(:each) do
      @user = create(:user)
      @payment = create(:payment)
      @payment_attributes = attributes_for(:payment, :user_id => @user.id)
      @order_attributes = attributes_for(:order, :payment_id => @payment.id, :user_id => @user.id )
      VCR.use_cassette("create a payment method") do
        Payment.create_payment_method(@payment_attributes)
       end
      ActionMailer::Base.deliveries = []
    end

    it "charges the customers credit card" do
      VCR.use_cassette("charges customers card", :record => :once ) do
        payment = Payment.create_payment_method(@payment_attributes)
        order_attr = FactoryGirl.attributes_for(:order, :payment_id => payment.id, :user_id => @user.id)
        expect(order.charge_customer(order_attr)).to be_true
      end
    end

    it "sends an email to the customer upon order completion" do
      VCR.use_cassette("charges customers card") do
        mail = OrderMailer.new_order_email(order)
        order.charge_customer(@order_attributes)
        expect(ActionMailer::Base.deliveries).to include(mail)
      end
    end

    it "cancels the order" do
      VCR.use_cassette("cancels the order") do
        order.charge_customer(@order_attributes)
        order_attributes = create(:order, :status => "Cancelled", :stripe_id => order.stripe_id)
        order = Order.update_order(order_attributes)
        order.status.should == "Cancelled"
      end
    end

    it "gives an error when an invalid request is made" do
      VCR.use_cassette("an error occurs when an invalid request has been made") do
        order_attributes = create(:order, :status => "Cancelled", :stripe_id => "")
        o = Order.update_order(order_attributes)
        o.should be_false
      end
    end

    it "updates the order status to dispatched" do
      order = create(:order, :status => "Dispatched")
      Order.update_order(order)
      order.status.should == "Dispatched"
    end

    it "emails the customer their order has been dispatched" do
      order = FactoryGirl.create(:order, :status => "Dispatched")
      dispatch_mail = OrderMailer.dispatch_email(order)
      ActionMailer::Base.deliveries = []
      Order.update_order(order)
      ActionMailer::Base.deliveries.should include(dispatch_mail)
    end
  end
end
