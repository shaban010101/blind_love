require 'spec_helper'

describe Product do
	subject { FactoryGirl.build(:product) }

	it { should validate_presence_of(:price) }
	it { should validate_presence_of(:name) }
	it { should validate_presence_of(:description) }
	it { should validate_uniqueness_of(:name) }
	it { should belong_to(:department) }
	it { should belong_to(:category) }
	it { should have_many(:sizes).through(:sizings)}
	it { should have_many(:basket_item) }
	it { should have_attached_file(:image) }
	it { should validate_attachment_presence(:image) }

	it "only numeric values should be valid" do
		subject.price = "4hfhf"
		subject.should_not be_valid
	end
end