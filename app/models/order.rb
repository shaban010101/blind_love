require "stripe"

class Order < ActiveRecord::Base
  attr_accessible :basket_id, :total, :payment_id, :address_id, :user_id, :stripe_id, :status

  has_many :basket_items
  belongs_to :basket
  belongs_to :user
  belongs_to :payment
  belongs_to :address

  validates :address_id, :presence => true

  scope :this_user, lambda { |user| where(:user_id => user) }

  before_validation :totals
  # after_save :deduct_from_stock
  # after_save :give_order_id

  def get_basket_items(basket)
    basket.basket_items.each do |basket_item|
      basket_item
    end
  end

  def after_save(basket)
    basket.basket_items.each do |basket_item|
      quant = basket_item.sizing.quantity - basket_item.quantity
      basket_item.sizing.decrement(:quantity, quant).inspect
    end
  end

  def after_save(basket)
    basket.basket_items.each do |basket_item|
     basket_item.update_attributes(:order_id => self.id)
    end
  end

  def totals
    self.total = basket_items.product_totals(basket_id)
  end

  def charge_customer(order)
    totes = self.totals
    stripe_id = Payment.where(:user_id => order[:user_id]).select(:stripe).last
    stripe_id = stripe_id.attributes["stripe"]
    c = Stripe::Charge.create({ :customer => stripe_id, :amount => totes, :currency => "gbp" })
    self.stripe_id = c.id
    save!
  rescue Stripe::CardError => e
    logger.error "Stripe error while trying to charge the customer: #{e.message}"
    errors.add :base, "There was a problem with your credit/debit card."
    false
  end

  def self.cancel_order(id)
    order = self.find(id)
    c = Stripe::Charge.retrieve(:id => order.stripe_id)
    c.refund
    order.update_attributes(:status => "Cancelled")
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error please try again: #{e.message}"
    order.errors.add :base, "There was a problem with caneling your order please try again."
    false
  end
end




