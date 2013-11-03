require 'spec_helper'

describe Order do
  before(:each) do
    @basket_item = FactoryGirl.create(:basket_item)
    @basket = FactoryGirl.create(:basket)
    @order = FactoryGirl.build(:order, :basket_id => @basket.id)
  end
end
