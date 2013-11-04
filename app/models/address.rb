class Address < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :post_code, :user_id

  belongs_to :user
  has_many :orders

  validates :address_1, :address_2, :post_code, :city, :presence => true
  validates_uniqueness_of :address_1, :address_2,  :scope => :user_id

  scope :this_user, lambda { |user| where(:user_id => user) }
end
