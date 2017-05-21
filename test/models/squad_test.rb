require 'test_helper'

class SquadTest < ActiveSupport::TestCase

  test "maximum must be greater then minimum" do
    squad = build(:squad)
    assert squad.valid?
    squad.maximum = 1
    squad.minimum = 5
    refute squad.valid?
  end

  test "users can be mentors or mentees" do
    squad = create(:squad)
    squad.add_member(create(:user))
    squad.add_member(create(:mentor))
    assert_equal 1, squad.mentors.count
    assert_equal 1, squad.members.count
  end

  test "can have many mentors" do
    squad = create(:squad, :with_mentors)
    assert squad.valid?
    squad.mentors << create(:user)
    refute squad.valid?
  end

  test "can have many members" do
    user = create(:user)
    squad = create(:squad)
    squad.add_member(user)
    assert_equal 1, squad.members.count
  end

end
