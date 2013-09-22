require "stripe"

class Order < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :first_name, :last_name, :title, :basket_id, :total, :cvc, :number, :year, :month
  attr_accessor :cvc, :number, :month, :year


  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :address_1, :presence => true
  validates :address_2, :presence => true
  validates :year, :presence => true
  validates  :month, :presence => true
  validates_format_of :year, :with => /\d{2,4}/
  validates_format_of :month, :with => /\d{1,2}/
  validate :year_cannot_be_in_the_past
  validate :invalid_month_and_year
  
  has_many :basket_items
  belongs_to :basket

  before_save :product_totals
  # after_save :empty_the_basket

  # def empty_the_basket
  #   basket = self.basket_id
  #   basket.destroy
  # end

  def year_cannot_be_in_the_past
    if self.year < Time.now.year
      errors.add(:year, "can't be in the past")
    end
  end

  def invalid_month_and_year
    if self.year < Time.now.year && self.month < Time.now.month
      errors.add(:month, "can't be in the past")
      errors.add(:year, "can't be in the past")
    end
  end

  def product_totals
    self.total = basket_items.product_totals
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
    errors.add :base, "There was a problem with your credit/debit card. #{e.code}"
    false
  end
end
