require 'stripe'

class Payment < ActiveRecord::Base
  attr_accessible :stripe, :cvc, :number, :year, :month, :basket, :user_id, :last4, :exp_month, :exp_year, :type
  attr_accessor :cvc, :number, :month, :year

  belongs_to :user
  has_many :orders

  validates :year, :presence => true
  validates :month, :presence => true
  validates :year, :numericality => true
  validates :month, :numericality => true
  validates :month, :length => { :in => 1..2 }
  validates :user_id, :presence => true 

  scope :only_this_user, lambda {|user| where(:user_id => user) }

  def create_payment_method
    c = Stripe::Customer.create({ :card => { :number => number, :exp_month => month, 
      :cvc => cvc, :exp_year => year }})
    self.stripe = c.id
    self.last4 = c.last4
    self.type = c.type
    self.exp_year = c.exp_year
    self.exp_month = c.exp_month
    save!
  rescue Stripe::CardError => e
    logger.error "Stripe error while trying to create the payment method: #{e.message}"
    errors.add :base, "There was a problem with your credit/debit card."
    false
  end

  def update_payment_method
    c = Stripe::Customer.retrieve({ :id => stripe, :card => { :number => number, :exp_month => month, :cvc => cvc, :exp_year => year } })
    self.stripe = c.id
    self.last4 = c.last4
    self.type = c.type
    self.exp_year = c.exp_year
    self.exp_month = c.exp_month
    save!
  rescue Stripe::CardError => e
    logger.error "Stripe error while trying to create the payment method: #{e.message}"
    errors.add :base, "There was a problem with your credit/debit card."
    false
  end

  def expiry_year_and_month
    "#{exp_month} #{exp_year}"
  end
end