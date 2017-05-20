class RequestPolicy < ApplicationPolicy
  attr_reader :user, :request

  def initialize(user, request)
    @user = user
    @request = request
  end

  def index?
    user.mentor?
  end

  def show?
    user.mentor?
  end

end
