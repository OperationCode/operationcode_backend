
class Ability
  include CanCan::Ability

  # Follows CanCanCan best practices for granting permissions.
  #
  # @see https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities%3A-Best-Practices#give-permissions-dont-take-them-away
  #
  def initialize(user)
    return unless user.persisted?

    if user.class == AdminUser
      return unless user.role&.board_accessible?
      can :read, ActiveAdmin::Page, name: 'Dashboard', namespace_name: 'admin'
      can :read, CodeSchool
      can :read, Location
      can :read, Service
      can :read, TeamMember
      can :read, User
      can [:read, :update], AdminUser, id: user.id

      return unless user.role&.admin_accessible?
      can :read, :all
      can :manage, CodeSchool
      can :manage, Location
      can :manage, Service
      can :manage, TeamMember

      return unless user.role&.super_admin?
      can :manage, :all
    else
      return unless user.mentor?
      can :read, Request
    end
  end
end
