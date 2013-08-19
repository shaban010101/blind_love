require 'spec_helper'

describe Basket do
  subject { FactoryGirl.create(:basket) }

  it { should have_many(:basket_items) }
end
