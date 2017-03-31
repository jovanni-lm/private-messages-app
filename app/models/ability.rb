class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin
      can :manage, :all
    else
      can :read, :all
      can :update, User, id: user.id
      cannot :show, User, blocked: true
    end

    cannot :show, User, id: user.id
  end
end
