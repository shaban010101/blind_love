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
    payment_attr = self.new
    stripe_response = c["cards"]["data"][0]
    payment_attr.save_attributes(stripe_response, payment)
    payment_attr.save!
  rescue Stripe::CardError => e
    logger.error "Stripe error while trying to create the payment method: #{e.message}"
    errors.add :base, "There was a problem with your credit/debit card."
    false
  end

  def save_attributes(res,payment)
    attributes = { :last_four => res["last4"], :card_type => res["type"], 
    :expiry_year => res["exp_year"], :expiry_month => res["exp_month"], :stripe => res[:customer], 
    :month => payment[:month], :year => payment[:year], :user_id => payment[:user_id] }

    attributes.each do |k,v|
      self.send("#{k}=","#{v}")
    end
  end

  def expiry_year_and_month
    "#{expiry_month} / #{expiry_year}"
  end

private
  def delete_cards
    self.class.where(:user_id => user_id).destroy_all
  end
end