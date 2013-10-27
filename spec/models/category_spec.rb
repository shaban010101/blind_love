require 'spec_helper'

describe Category do
	let(:category) { FactoryGirl.create(:category) }

	it { should have_many(:products) }
  it { should have_many(:departments).through(:category_departments) }
  it { should have_many(:category_departments) }
	it { should validate_presence_of(:category_name) }

end
