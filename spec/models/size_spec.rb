require 'spec_helper'

describe Size do
  
  it { should have_many(:sizings) }
  it { should have_many(:products).through(:sizings) }
end
