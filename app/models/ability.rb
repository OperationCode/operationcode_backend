class Ability
  include CanCan::Ability

  def initialize(user)
    # Follows CanCanCan best practices for granting permissions.
    #
    # @see https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities%3A-Best-Practices#give-permissions-dont-take-them-away
    #
    if user.persisted? && user.class == AdminUser
      return unless user.role&.board_accessible?
      can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"
      can :read, User
      can [:read, :update], AdminUser, id: user.id

      return unless user.role&.admin_accessible?
      can :read, :all
      can :manage, User

      return unless user.role&.super_admin?
      can :manage, :all
    end
  end
end
