require "stripe"

class Order < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :first_name, :last_name, :title, :basket_id, :total, :cvc, :number, :year, :month, :basket
  attr_accessor :cvc, :number, :month, :year

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :address_1, :presence => true
  validates :address_2, :presence => true
  validates :year, :presence => true
  validates :month, :presence => true
  validates :year, :numericality => true
  validates :month, :numericality => true
  validates :month, :length => { :in => 1..2 } 
 
  has_many :basket_items
  belongs_to :basket

  before_save :product_totals

  def product_totals
    self.total = basket_items.product_totals(basket_id)
  end

  def charge_customer
    Stripe::Charge.create({
      :amount => total,
      :currency => "gbp",
      :card => { :number => number, :exp_month => month, :cvc => cvc, :exp_year => year},
      :description => "#{first_name} #{last_name}"})
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
