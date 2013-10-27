require 'spec_helper'

describe Product do
	let(:category) { FactoryGirl.create(:category) }
	let(:department) { FactoryGirl.create(:department) }
 	subject { FactoryGirl.create(:product) }

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

		it "should return product name entered" do
			Product.search(subject)
			.should == [subject]
		end

		it "should return lowest to highest range" do
			[9, 10].each do |price| 
				FactoryGirl.create(:product, :price => price)
			end

			Product.lowest_or_highest("ASC").map { |p| [p.price] }
			.should == [[9], [10]]
		end

		it "lists sizes available for category and also how many for each size" do
			subject = FactoryGirl.create(:product, :category_id => category.id)
			size = FactoryGirl.create(:size)
			sizing = FactoryGirl.create(:sizing, :size_id => size.id, :product_id => subject.id )
			Product.sizes(size.id)
			.should == [subject]
		end	
	end
end