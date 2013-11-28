class Ability
  include CanCan::Ability

  def initialize(user)
   
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.customer?
      can :create, Order
      
      can :read, :edit, Order do |order|
        order == user
      end

      can :cancel, Order do |order|
        order == user
      end
    end
  end
end
