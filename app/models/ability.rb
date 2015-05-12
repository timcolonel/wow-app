class Ability
  include CanCan::Ability

  def initialize(user)
    # user ||= User.new
    can :manage, :all
    if user.nil?
      cannot :read, Tag
    end
  end
end
