class SquadPolicy < ApplicationPolicy
  attr_reader :user, :squad

  def initialize(user, squad)
    @user = user
    @squad = squad
  end

  def index?
    true
  end

  def create?
    user.mentor?
  end

end
