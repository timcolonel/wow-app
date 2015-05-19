class Ability
  include CanCan::Ability

  def initialize(user)
    # user ||= User.new
    if user.nil?
      can :read, :all
    else
      can :manage, :all
    end
  end
end
