require "spec_helper"

describe OrderMailer do
  let(:user) { create(:user) }
  let(:order) { create(:order, :user_id => user.id) }
  let(:new_order) { OrderMailer.new_order_email(order) }
  let(:dispatch_email) { OrderMailer.dispatch_email(order) }

  before(:each) do
    ActionMailer::Base.deliveries = []
  end

  it "renders the correct subject, to, from for new order emails" do
    expect(new_order.subject).to eq("New Order")
    expect(new_order.to).to eq([user.email])
    expect(new_order.from).to eq(["at@exmple.com"])
  end

  it "renders the correct subject, to, from for dispatched emails" do
    expect(dispatch_email.subject).to eq("Order Dispatch")
    expect(dispatch_email.to).to eq([user.email])
    expect(dispatch_email.from).to eq(["at@exmple.com"])
  end

  it "sends the email when an order is created" do
    new_order.deliver
    expect(ActionMailer::Base.deliveries).to include(new_order)
  end

  it "sends the email when an order is dispatched" do
    dispatch_email.deliver
    expect(ActionMailer::Base.deliveries).to include(dispatch_email)
  end  

  it "contain this body in the email for dispatched orders" do
    expect(dispatch_email.body).to include("Your order has just been dispatched")
  end

  it "contain this body in the email for new orders" do
    expect(new_order.body).to include("We have just recieved your order and it is now being processed")
  end
end
