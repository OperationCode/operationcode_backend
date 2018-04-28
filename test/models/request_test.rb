require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  test "the truth" do
    request = create(:request)
    p request.requested_mentor
  end
  
end
