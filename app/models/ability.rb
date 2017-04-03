class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin
      can :manage, :all
    else
      can :read, User, blocked: false
      can :update, User, id: user.id
    end

    cannot :show, User, id: user.id
  end
end
