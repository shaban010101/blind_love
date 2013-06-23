require 'spec_helper'

describe Category do
	let(:category) { FactoryGirl.create(:category) }

	it { should have_many(:products) }
	it { should belong_to(:department) }
	it { should validate_presence_of(:category_name) }

end
