require 'spec_helper'

describe Category do
	let(:category) { FactoryGirl.create(:category) }

	it { should have_many(:products) }
	it { should belong_to(:department) }
	it { should validate_presence_of(:department_id) }
	it { should validate_presence_of(:category_name) }

	it "has two products for this category" do
		expect(FactoryGirl.create(:category_with_products).products.length).to eq 100
	end

end
