require 'spec_helper'

describe Basket do
  let(:basket) { FactoryGirl.build(:basket) }

  it { should have_many(:basket_item) }
end
