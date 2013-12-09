class OrderMailer < ActionMailer::Base
  default from: "at@exmple.com"

  def new_order_email(order)
    @order = Order.find(order[:id])
    @user = @order.user
    mail(:to => @user.email, :subject => "New Order", :content_type => "text/html")
  end

  def dispatch_email(order)
    @order = Order.find(order[:id])
    @user = @order.user
    mail(:to => @user.email, :subject => "Order Dispatch", :content_type => "text/html")
  end
end
