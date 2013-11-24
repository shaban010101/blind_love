class Ability
  include CanCan::Ability

  def initialize(user)
   
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.customer?
      can :create, :all
      can :read, :edit, Order do |order|
        order.try(:user) == user
      end
    end
  end
end
