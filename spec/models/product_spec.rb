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
			product.category_id = category.id
			product.save
			Product.products_category(category).map {|p| [p.name] }
			.should == ["#{product.name}"]
		end

		it "should return product name entered" do
			product = FactoryGirl.create(:product)
			Product.search("#{product.name}").should == ["#{product.name}"]
		end

		it "should return lowest to highest range" do
			["nuts", "moin"].each do |name| 
				FactoryGirl.create(:product, :name => name)
			end

			Product.lowest_or_highest("DESC").map { |p| [p.name] }
			.should == [["moin"], ["nuts"]]
		end
	end
end