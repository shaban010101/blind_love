require 'spec_helper'

describe HomePagesController do
  describe "#index" do
    it "shows the normal index page" do
      get "index"
      response.should be_success
    end
  end
end