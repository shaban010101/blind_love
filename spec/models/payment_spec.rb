  require 'spec_helper'

describe "Payment" do
  let(:payment) { create(:payment) }
  
  it "validation error when year is not a number" do
    payment.year = "jfjfjf"
    payment.should_not be_valid
  end

  it "validation error when month is not a number" do
    payment.month = "jfjfjf"
    payment.should_not be_valid
  end

  it "validation error when the month is not in the correct format" do
    payment.month = 213
    payment.should_not be_valid
  end

  it "validation error when the month is blank" do
    payment.month = ""
    payment.should_not be_valid
  end

  it "validation error when the month is blank" do
    payment.year = ""
    payment.should_not be_valid
  end

  it "creates a payment" do
    VCR.use_cassette("create a payment method") do
      payment = attributes_for(:payment)
      Payment.create_payment_method(payment)
    end
  end
end