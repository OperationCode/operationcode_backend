require 'test_helper'

class Api::V1::JobsControllerTest < ActionDispatch::IntegrationTest

  test "index endpoint should return job parameters in JSON format" do
    jobs = []
    5.times do
      jobs << create(:job)
    end
    get api_v1_jobs_url, as: :json
    i = 0
    response.parsed_body.each do |response|
      assert_equal true, response["title"] == jobs[i].title
      i += 1
    end
  end
end

