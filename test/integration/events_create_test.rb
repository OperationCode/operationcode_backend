require 'test_helper'

class EventsCreateTest < ActionDispatch::IntegrationTest
  setup do
    Event.delete_all
  end

  test 'valid event information saves' do
    assert_difference 'Event.count', 1 do
      create :event, :updated_today
    end
  end
end