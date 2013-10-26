class SearchesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:index]

  def index
    @cp = Product.search(params)
  end
end