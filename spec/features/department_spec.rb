require 'spec_helper'

feature "Department" do
	let(:department) { FactoryGirl.create(:department) }
	scenario "Editing" do
		visit edit_admin_department_path(department.slug)
	end
end