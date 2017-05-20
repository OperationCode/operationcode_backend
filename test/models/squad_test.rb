require 'test_helper'

class SquadTest < ActiveSupport::TestCase

  test "maximum must be greater then minimum" do
    squad = build(:squad)
    assert squad.valid?
    squad.maximum = 1
    squad.minimum = 5
    refute squad.valid?
  end
end
