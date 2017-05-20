require 'test_helper'

class SquadTest < ActiveSupport::TestCase

  test "maximum must be greater then minimum" do
    squad = build(:squad)
    assert squad.valid?
    squad.maximum = 1
    squad.minimum = 5
    refute squad.valid?
  end

  test "can have many mentors" do
    squad = create(:squad, :with_mentors)
    assert squad.valid?
    squad.mentors << create(:user)
    refute squad.valid?
  end
end
