def login_into_account
  @user = FactoryGirl.create(:user)
  visit '/users/sign_in'
  fill_in "Email", :with => @user.username
  fill_in "Password", :with => @user.password
  click_button "Sign in"
  visit("/users/#{user.id}")
  # page.driver.post '/users/sign_in', :username => @user.username, :password => @user.password
end 
