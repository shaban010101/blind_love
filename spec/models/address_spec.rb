require 'spec_helper'

describe Address do
  let(:address) { FactoryGirl(:address) }

  it { should belong_to(:user) }
  it { validate_presence_of(:address_1) }
  it { validate_presence_of(:address_2) }
  it { validate_presence_of(:post_code) }
  it { validate_presence_of(:user_id) }
  it { validate_uniqueness_of(:address_1) }
  it { validate_uniqueness_of(:address_2) }

  it "should give a validation warning if the user tries to create more than three addresses" do
    user = FactoryGirl.create(:user)
    3.times do 
      address = FactoryGirl.create(:address, :user_id => user.id)
    end
  end
end
