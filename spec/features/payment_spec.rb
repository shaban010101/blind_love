require 'spec_helper'


feature "Payment" do
  let(:user) { create(:user) }
  let(:payment) { create(:payment) }
  

  before(:each) do
    visit new_user_session_path
    login_as(user, :scope => :user)
  end

  it "allow a user to create a payment method" do
    VCR.use_cassette("create a payment method") do
      visit user_payments_path(user)
      click_on("Create/Edit a credit/debit card to pay with")
      visit new_user_payment_path(user)
      fill_in "payment_number" , :with => payment.number
      fill_in "payment_cvc", :with => payment.cvc
      fill_in "payment_month", :with => payment.month
      fill_in "payment_year", :with => payment.year
      click_button "Create Payment"
    end
  end 
end