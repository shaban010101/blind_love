class Payment < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :card_no, :csv, :exp_date, :first_name, :last_name, :start_date, :title, :basket_id
  has_many :basket_items
end
