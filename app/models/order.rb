require "stripe"

class Order < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :first_name, :last_name, :title, :basket_id, :total, :cvc, :number, :year, :month
  attr_accessor :cvc, :number, :year, :month


  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :address_1, :presence => true
  validates :address_2, :presence => true
  
  has_many :basket_items

  before_save :product_totals

  def product_totals
    self.total = basket_items.product_totals
  end

  # def charge_customer
  #   begin
  #     Stripe::Charge.create({
  #       :amount => total,
  #       :currency => "gbp",
  #       :card => { :number => number, :exp_month => month, :cvc => cvc, :exp_year => year },
  #       :description => "#{first_name} #{last_name}"})
  #   rescue Stripe::InvalidRequestError => e
  #     logger.error "Stripe error while trying to charge the customer: #{e.message}"
  #     errors.add :base, "There was a problem with your credit/debit card."
  #   end
  # end
end
