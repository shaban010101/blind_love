class Address < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :post_code, :user_id

  belongs_to :user
  has_many :orders

  validates :address_1, :address_2, :post_code, :city, :user_id, :presence => true
  validates_uniqueness_of :address_1, :address_2,  :scope => :user_id

  scope :this_user, lambda { |user| where(:user_id => user) }
  # validate :only_three_addresses_per_user

  # def only_three_addresses_per_user
  #   unless self.user.size > 3
  #     errors.add(:user, "No more than three addresses allowed")
  #   end
  # end 
end
