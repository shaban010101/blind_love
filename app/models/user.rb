class User < ActiveRecord::Base
  attr_accessible :password, :username
  has_secure_password
  validates_presence_of :username, :on => :create
  validates_presence_of :password, :on => :create
end
