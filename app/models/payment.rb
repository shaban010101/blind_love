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

  def create_payment_method
    c = Stripe::Customer.create({ :card => { :number => number, :exp_month => month, 
      :cvc => cvc, :exp_year => year }})
    self.stripe = c.id 
    self.last_four = c["cards"]["data"][0]["last4"]
    self.card_type = c["cards"]["data"][0]["type"]
    self.expiry_year = c["cards"]["data"][0]["exp_year"]
    self.expiry_month = c["cards"]["data"][0]["exp_month"]
    save!
  rescue Stripe::CardError => e
    logger.error "Stripe error while trying to create the payment method: #{e.message}"
    errors.add :base, "There was a problem with your credit/debit card."
    false
  end

  def update_payment_method
    c = Stripe::Customer.retrieve({ :id => stripe, :card => { :number => number, :exp_month => month, :cvc => cvc, :exp_year => year } })
    self.stripe = c.id
    self.last_four = c["cards"]["data"][0]["last4"]
    self.card_type = c["cards"]["data"][0]["type"]
    self.expiry_year = c["cards"]["data"][0]["exp_year"]
    self.expiry_month = c["cards"]["data"][0]["exp_month"]
    save!
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