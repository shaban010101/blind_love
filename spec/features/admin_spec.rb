require 'spec_helper'

feature 'Admin' do
	before(:each) do
		@user = FactoryGirl.create(:user, :role => "admin")
	end

	scenario "should login into the dashboard" do
		visit new_user_session_path
		login_as(@user, :scope => :user)
	end
end