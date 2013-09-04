require "stripe"

class Order < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :first_name, :last_name, :title, :basket_id, :total 
  attr_accessor :cvc, :number, :year, :month

  validates_presence_of :address_1
  validates_presence_of :address_2
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  has_many :basket_items

  before_save :product_totals

  def product_totals
    self.total = basket_items.product_totals
  end

  def charge_customer
    begin
      Stripe::Charge.create(
        :amount => total,
        :currency => "gbp",
        :card => { :number => number, :exp_month => month, :cvc => cvc, :exp_year => year },
        :descrption => "#{first_name} #{last_name}")
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while trying to charge the customer: #{e.message}"
      errors.add :base, "There was a problem with your credit/debit card."
    end
  end
end
