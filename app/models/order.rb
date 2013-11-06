require "stripe"

class Order < ActiveRecord::Base
  attr_accessible :basket_id, :total, :payment_id, :address_id, :user_id, :stripe_id
  attr_accessor :total, :stripe_id

  has_many :basket_items
  belongs_to :basket
  belongs_to :user
  belongs_to :payment
  belongs_to :address

  before_save :product_totals

  def product_totals
   self.total = basket_items.where("basket_items.basket_id" => basket_id).sum(:item_price)
  end

  def charge_customer
    stripe_id = Payment.where(:user_id => user_id).select(:stripe).last
    stripe_id = stripe_id.attributes["stripe"]
    Stripe::Charge.create({ :customer => stripe_id, :amount => total, :currency => "gbp" })
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
