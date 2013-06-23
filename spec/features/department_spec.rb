require 'spec_helper'

feature "Department" do
	scenario "Editing" do
		@department = FactoryGirl.create(:department)
		visit edit_admin_department_path(@department.slug)
	end

	scenario "denied entry when not logged in" do
	end
end