class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :role

  has_many :addresses
  has_one :payment

  def customer?
    self.role == "customer"
  end

  def admin?
    self.role == "admin"
  end
  
end
