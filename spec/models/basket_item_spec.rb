require 'spec_helper'

describe BasketItem do
  subject { FactoryGirl.create(:basket_item) }
  it { should belong_to(:basket) }
  it { should belong_to(:product) }
end
