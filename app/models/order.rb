require "stripe"

class Order < ActiveRecord::Base
  attr_accessible :basket_id, :total, :payment_id, :address_id, :user_id, :stripe_id, :status

  STATUS = ["Cancelled", "Dispatched", "Processing"]

  has_many :basket_items
  belongs_to :basket
  belongs_to :user
  belongs_to :payment
  belongs_to :address

  validates :address_id, :presence => true

  scope :this_user, lambda { |user| where(:user_id => user) }
  scope :cancelled, lambda { where(:status => "Cancelled") }
  scope :dispatched, lambda { where(:status => "Dispatched") }
  scope :processing, lambda { where(:status => 'Processing') }

  before_validation :totals
  after_save :give_order_id
  after_save :new_order, :only => :create

  def get_basket_items(basket)
    basket.basket_items.each do |basket_item|
      basket_item
    end
  end

  def give_order_id
    self.basket.basket_items.each do |basket_item|
     basket_item.update_attributes(:order_id => self.id)
    end
  end

  def totals
    self.total = basket_items.product_totals(basket_id)
  end

  def retrieve_stripe_id(order)
    stripe_id = Payment.where(:user_id => order[:user_id]).select(:stripe).last
    stripe_id = stripe_id.attributes["stripe"]
  end

  def charge_customer(order)
    totes = self.totals
    stripe_id = retrieve_stripe_id(order)
    c = Stripe::Charge.create({ :customer => stripe_id, :amount => totes, :currency => "gbp" })
    self.stripe_id = c.id
    save!
  rescue Stripe::CardError => e
    logger.error "Stripe error while trying to charge the customer: #{e.message}"
    errors.add :base, "There was a problem with your credit/debit card."
    false
  end

  def self.update_order(order)
    order_object = self.find(order[:id])
    order_attributes = order

    if order_attributes[:status] == "Cancelled"
      begin
        c = Stripe::Charge.retrieve(:id => order_object.stripe_id)
        c.refund
        order_object.update_column(:status, "Cancelled")
      rescue Stripe::InvalidRequestError => e
        logger.error "Stripe error please try again: #{e.message}"
        order_object.errors.add :base, "There was a problem with caneling your order please try again."
        false
      end
    else 
      order_object.update_column(:status, "Dispatched")
      order_object.order_dispatch(order_object)
    end
  end
 
  def order_dispatch(order)
    OrderMailer.dispatch_email(self).deliver
  end

  def new_order
    OrderMailer.new_order_email(self).deliver
  end

  def add_attributes(attributes)
    attributes.each do |k,v|
     self.send("#{k}=", "#{v}")
    end 
  end
end




