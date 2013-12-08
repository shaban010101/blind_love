require 'spec_helper'


feature "AdminOrder" do 
  scenario "shows a page with all orders" do
    visit admin_orders_path
  end
end