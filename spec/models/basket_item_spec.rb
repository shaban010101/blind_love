require 'spec_helper'

describe BasketItem do
  let(:basket_item) { FactoryGirl.build(:basket_item) }
  it { should belong_to(:basket) }
  it { should belong_to(:product) }
end
