require 'test_helper'

class SquadPolicyTest < ActiveSupport::TestCase

  test "user" do
    user = build(:user)
    policy = SquadPolicy.new(user, nil)
    assert policy.index?
    refute policy.create?
    assert policy.join?
    assert policy.show?
  end

  test "mentors" do
    user = build(:mentor)
    policy = SquadPolicy.new(user, nil)
    assert policy.index?
    assert policy.create?
    assert policy.join?
    assert policy.show?
  end

end
