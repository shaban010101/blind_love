require 'stripe'

class Payment < ActiveRecord::Base
  attr_accessible :stripe, :cvc, :number, :year, :month, :basket, :user_id, :last_four, :expiry_month, :expiry_year, :card_type
  attr_accessor :cvc, :number, :month, :year

  belongs_to :user
  has_many :orders

  validates :year, :presence => true
  validates :month, :presence => true
  validates :year, :numericality => true
  validates :month, :numericality => true
  validates :month, :length => { :in => 1..2 }

  scope :only_this_user, lambda {|user| where(:user_id => user) }

  before_save :delete_cards

  def self.create_payment_method(payment)
    c = Stripe::Customer.create({ :card => { :number => payment[:number], :exp_month => payment[:month], 
      :cvc => payment[:cvc], :exp_year => payment[:year] }})

    stripe_response = c["cards"]["data"][0]

    payment_attr = self.new
    payment_attr.assign_attributes({:last_four => stripe_response["last4"], :card_type => stripe_response["type"], 
    :expiry_year => stripe_response["exp_year"], :expiry_month => stripe_response["exp_month"], :stripe => c.id, 
    :month => payment[:month], :year => payment[:year], :user_id => payment[:user_id] })
    payment_attr.save!
  rescue Stripe::CardError => e
    logger.error "Stripe error while trying to create the payment method: #{e.message}"
    errors.add :base, "There was a problem with your credit/debit card."
    false
  end

  def expiry_year_and_month
    "#{expiry_month} / #{expiry_year}"
  end

private
  def delete_cards
    self.class.where(:user_id => user_id).destroy_all
  end
end