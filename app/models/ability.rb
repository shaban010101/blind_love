class Ability
  include CanCan::Ability

  def initialize(user)
   
    user ||= User.new
    if user.admin?
      can :read, Admin
      can :manage, Product
      can :manage, Category 
      can :manage, Order
    elsif user.customer?
      can :create, [Order, Payment, Address]
      can :read, [Order, Payment, Address]

      can [:update, :destroy], [Order, Address, Payment], :user_id => user.id

      can :cancel, Order do |order|
        order == user
      end
    end
  end
end
