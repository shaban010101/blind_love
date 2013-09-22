require 'spec_helper'

describe Product do
	before(:each) do
		@product = FactoryGirl.create(:product)
	end

	it { should validate_presence_of(:price) }
	it { should validate_presence_of(:name) }
	it { should validate_presence_of(:description) }
	it { should validate_uniqueness_of(:name) }
	it { should belong_to(:category) }
	it { should have_many(:sizes).through(:sizings)}
	it { should have_many(:basket_items) }
	it { should have_attached_file(:image) }
	it { should validate_attachment_presence(:image) }

	it "only numeric values should be valid" do
		@product.price = "4hfhf"
		@product.should_not be_valid
	end

	context "scopes" do

		it "should return products for the departments categories" do
			Product.mens_category("Trousers").should == [@product]
		end
	end
end