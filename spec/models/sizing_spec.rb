require 'spec_helper'

describe Sizing do
  let(:size) { FactoryGirl.create(:size) }
  let(:sizing) { FactoryGirl.create(:sizing, :size_id => size.id) }
  it { should belong_to(:product) } 
  it { should belong_to(:size) }

  it "show sizes which are greater than a quantity of zero" do
    other_size = FactoryGirl.create(:sizing, :quantity => 0)
    Sizing.in_stock.should == [sizing]
  end
end
