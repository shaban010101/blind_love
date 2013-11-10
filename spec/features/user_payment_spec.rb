require 'spec_helper'


feature "Payment" do
  let(:user) { FactoryGirl.create(:user) }
  let(:payment) { FactoryGirl.create(:payment) }
  

  before(:each) do
    visit new_user_session_path
    fill_in "Email", :with => user.email 
    fill_in "Password", :with => user.password
    click_button "Sign in"
    page.should have_content("Signed in successfully.")
  end

  it "allow a user to create a payment method" do
    visit user_payments_path(user)
    click_on("Create/Edit a credit/debit card to pay with")
    visit new_user_payment_path(user)
    fill_in "payment_number" , :with => payment.number
    fill_in "payment_cvc", :with => payment.cvc
    fill_in "payment_month", :with => payment.month
    fill_in "payment_year", :with => payment.year
  end 
  
end