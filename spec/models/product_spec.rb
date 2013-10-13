require 'spec_helper'

describe Product do
	let(:category)  { FactoryGirl.build(:category) }
 	let(:product) { FactoryGirl.build(:product) }

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
		product.price = "4hfhf"
		product.should_not be_valid
	end

	it "should downcase name" do
		product.name = "HUGO"
		product.save
		product.name.should == "hugo"
	end

	context "scopes" do
		it "should return products for the departments categories" do
			category = FactoryGirl.create(:category)
			product_one = FactoryGirl.create(:product, :category_id => category.id)
			expect(Product.products_category(category)).to eq([product_one])
		end
	end
end