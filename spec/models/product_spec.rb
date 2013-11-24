require 'spec_helper'

describe Product do
	let(:category) { FactoryGirl.create(:category) }
	let(:department) { FactoryGirl.create(:department) }
 	subject { FactoryGirl.create(:product) }

	it { should validate_presence_of(:price) }
	it { should validate_presence_of(:name) }
	it { should validate_presence_of(:description) }
	it { should validate_presence_of(:category_department_id) }
	it { should validate_uniqueness_of(:name) }
	it { should belong_to(:category) }
	it { should have_many(:sizes).through(:sizings)}
	it { should have_many(:basket_items) }
	it { should have_attached_file(:image) }
	it { should validate_attachment_presence(:image) }

	it "only numeric values should be valid" do
		subject.price = "4hfhf"
		subject.should_not be_valid
	end

	it "should downcase name" do
		subject.name = "HUGO"
		subject.save
		subject.name.should == "hugo"
	end

	context "scopes" do
		it "should return products for the departments categories" do
			product = FactoryGirl.create(:product, :department_id => department.id, :category_id => category.id)
			Product.products_category(category)
			.should == [product]
		end

		it "returns products which match product name entered" do
			Product.search(subject)
			.should == [subject]
		end

		it "returns products in ascending order" do
			[9, 10].each do |price| 
				FactoryGirl.create(:product, :price => price)
			end

			Product.lowest_or_highest("ASC").map { |p| [p.price] }
			.should == [[9], [10]]
		end

		it "returns products in descending order" do
			[9, 10].each do |price| 
				FactoryGirl.create(:product, :price => price)
			end

			Product.lowest_or_highest("DESC").map { |p| [p.price] }
			.should == [[10], [9]]
		end

		it "filter by size" do
			subject = FactoryGirl.create(:product, :category_id => category.id)
			size = FactoryGirl.create(:size)
			other_size = FactoryGirl.create(:size)
			other_sizing = FactoryGirl.create(:sizing, :size_id => other_size.id, :product_id => subject.id)
			sizing = FactoryGirl.create(:sizing, :size_id => size.id, :product_id => subject.id )
			Product.sizes(size.id)
			.should == [subject]
		end

		it "produces a range of prices in 100s for product prices" do
			other_product = FactoryGirl.create(:product,:price => 9500, :category_id => category.id)
			product = FactoryGirl.create(:product, :category_id => category.id)

			expect(Product.workout_min_and_max(category.id).map)
			.to include(9500,9600,9700,9800,9900,10000)
		end

		it "filters products based on min and max values provided" do
			other_product = FactoryGirl.create(:product,:price => 9500, :category_id => category.id)
			product = FactoryGirl.create(:product, :category_id => category.id)

			expect(Product.pricing(9500,9600).map)
			.to include(other_product)
		end	
	end
end