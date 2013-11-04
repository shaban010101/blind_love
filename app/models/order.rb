require "stripe"

class Order < ActiveRecord::Base
  attr_accessible :basket_id, :total, :payment_id, :address_id, :user_id, :stripe_id
  attr_accessor :stripe_id, :total 

  has_many :basket_items
  belongs_to :basket
  belongs_to :user
  belongs_to :payment
  belongs_to :address

  before_save :product_totals

  def product_totals
    self.total = basket_items.product_totals(basket_id)
  end

  def charge_customer
    raise Stripe::Charge.create({ :customer => stripe_id }).inspect
    save!
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while trying to charge the customer: #{e.message}"
    errors.add :base, "There was a problem with your credit/debit card."
    false
  rescue Stripe::CardError => e
    logger.error "Stripe error while trying to charge the customer: #{e.message}"
    errors.add :base, "There was a problem with your credit/debit card."
    false
  end
end
