require 'spec_helper'

describe Department do
  it { should have_many(:categories) }
  it { should validate_presence_of(:department_name)}
end
