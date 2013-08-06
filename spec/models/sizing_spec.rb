require 'spec_helper'

describe Sizing do
  it { should belong_to(:product) } 
  it { should belong_to(:size) }
end
