require 'test_helper'

class Api::V1::TagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    resource = create :resource

    resource.tag_list.add('books', 'videos')
    resource.save
  end

  test ':index endpoint returns JSON list of Tags' do
    get api_v1_tags_url, as: :json

    assert_equal response.status, 200
    ['books', 'videos'].each do |tag_name|
      assert_equal true, response.parsed_body.any? { |tag| tag['name'] == tag_name }
    end
  end
end
