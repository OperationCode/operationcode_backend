require 'test_helper'

class RequestPolicyTest < ActiveSupport::TestCase

  test "user" do
    user = build(:user)
    policy = RequestPolicy.new(user, nil)
    refute policy.index?
    refute policy.show?
  end

  test "mentors" do
    user = build(:mentor)
    policy = RequestPolicy.new(user, nil)
    assert policy.index?
    assert policy.show?
  end

end
