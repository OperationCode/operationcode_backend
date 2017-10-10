require 'test_helper'
require_relative '../support/meetups/sample_api_responses'

class MeetupTest < ActiveSupport::TestCase
	test "good data is saved" do
		Meetup.stubs(:get).with("pro/operationcode/groups", options).returns(group_endpoint_response) #Returns response which includes response.parsed_response and response.code
		parsed_response = Meetup.new.operationcode_data
		puts "#{parsed_response}"
		assert_equal 2, parsed_response.size
	end

	def options
		Meetup.new.options
	end
end
