require 'test_helper'

class Api::V1::ResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user)
    @headers = authorization_headers(user)

    @books = create(:resource)
    @videos = create(:resource, name: 'Free videos')
  end

  test ":index endpoint returns JSON list of Resources" do
    get api_v1_resources_url, as: :json

    assert_equal response.status, 200
    [@books.name, @videos.name].each do |resource_name|
      assert_equal true, response.parsed_body.any? { |response| response['name'] == resource_name }
    end
  end

  test ":index endpoint returns correct tagged Resources when :tags param is passed" do
    params = { tags: ['screencast', 'articles'] }
    blog = create(:resource, name: 'Blog posts')
    blog.tag_list.add 'articles'
    blog.save
    @videos.tag_list.add 'screencast'
    @videos.save

    get api_v1_resources_url(params), as: :json

    assert_equal response.parsed_body.size, 2
    [blog.name, @videos.name].each do |resource_name|
      assert_equal true, response.parsed_body.any? { |response| response['name'] == resource_name }
    end
  end

  test ":show endpoint returns JSON representation of the requested Resource" do
    get api_v1_resource_url(@books.id), as: :json

    assert_equal response.status, 200
    assert_equal @books.id, response.parsed_body["id"]
    assert_equal @books.name, response.parsed_body["name"]
    assert_equal @books.url, response.parsed_body["url"]
    assert_equal @books.category, response.parsed_body["category"]
  end

  test ":create endpoint creates a new Resource" do
    params = {
      resource: {
        name: 'Free videos site',
        url: 'free@videos.com',
        category: 'videos',
        language: 'multiple',
        paid: false,
      }
    }

    post api_v1_resources_url, headers: @headers, params: params, as: :json

    videos = Resource.last
    assert_equal({ 'resource' => videos.id }, response.parsed_body)
  end

  test ":update endpoint updates an existing Resource" do
    new_url = "more_free_videos@videos.com"
    params = {
      resource: {
        id: @videos.id,
        name: @videos.name,
        url: new_url,
        category: @videos.category,
        language: @videos.language,
        paid: @videos.paid
      }
    }

    put api_v1_resource_url(@videos.id), headers: @headers, params: params, as: :json

    @videos.reload
    assert_equal response.status, 200
    assert_equal @videos.url, new_url
  end

  test ":destroy endpoint destroys an existing Resource" do
    params = {
      resource: {
        id: @videos.id,
        name: @videos.name,
        url: @videos.url,
        category: @videos.category,
        language: @videos.language,
        paid: @videos.paid
      }
    }

    delete api_v1_resource_url(@videos.id), headers: @headers, params: params, as: :json

    assert_equal response.status, 200
    assert_equal 1, Resource.count
  end
end
