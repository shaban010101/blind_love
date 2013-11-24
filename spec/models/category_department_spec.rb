require 'spec_helper'

describe CategoryDepartment do
  it { should belong_to(:department) }
  it { should belong_to(:category) }
  it { should have_many(:products) }
end
