require 'test_helper'

class Api::V1::ResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user)
    @headers = authorization_headers(user)

    @books = create(:resource)
    @videos = create(:resource, name: 'Free videos')
  end

  test ':index endpoint returns JSON list of Resources' do
    get api_v1_resources_url, as: :json

    assert_equal response.status, 200
    [@books.name, @videos.name].each do |resource_name|
      assert_equal true, response.parsed_body.any? { |response| response['name'] == resource_name }
    end
  end

  test ':index endpoint returns correct tagged Resources when :tags param is passed' do
    params = { tags: 'screencast, articles' }
    blog = create(:resource, name: 'Blog posts')
    blog.tag_list.add 'articles', parse: true
    blog.save
    @videos.tag_list.add 'screencast',parse: true
    @videos.save

    get api_v1_resources_url(params), as: :json

    assert_equal response.parsed_body.size, 2
    [blog.name, @videos.name].each do |resource_name|
      assert_equal true, response.parsed_body.any? { |response| response['name'] == resource_name }
    end
  end

  test ':show endpoint returns JSON representation of the requested Resource' do
    get api_v1_resource_url(@books.id), as: :json

    assert_equal response.status, 200
    assert_equal @books.id, response.parsed_body['id']
    assert_equal @books.name, response.parsed_body['name']
    assert_equal @books.url, response.parsed_body['url']
    assert_equal @books.category, response.parsed_body['category']
  end

  test ':create endpoint creates a new Resource' do
    params = {
      name: 'Free videos site',
      url: 'free@videos.com',
      category: 'videos',
      language: 'multiple',
      paid: false,
    }

    post api_v1_resources_url, headers: @headers, params: params, as: :json

    videos = Resource.last
    assert_equal({ 'resource' => videos.id, 'tags' => [] }, response.parsed_body)
  end

  test ':create endpoint creates a new Resource with Tags' do
    params = {
      name: 'Free videos site',
      url: 'free@videos.com',
      category: 'videos',
      language: 'multiple',
      paid: false,
      tags: 'free, top 100'
    }

    post api_v1_resources_url, headers: @headers, params: params, as: :json

    videos = Resource.last
    assert_equal(
      { 'resource' => videos.id, 'tags' => videos.tags.map(&:name) },
      response.parsed_body
    )

    ['free', 'top 100'].each do |tag_name|
      assert_equal true, videos.tags.map(&:name).any? { |tag| tag == tag_name }
    end
  end

  test ':update endpoint updates an existing Resource' do
    new_url = 'more_free_videos@videos.com'
    params = {
      id: @videos.id,
      name: @videos.name,
      url: new_url,
      category: @videos.category,
      language: @videos.language,
      paid: @videos.paid
    }

    put api_v1_resource_url(@videos.id), headers: @headers, params: params, as: :json

    @videos.reload
    assert_equal response.status, 200
    assert_equal(
      { 'resource' => @videos.id, 'tags' => @videos.tags.map(&:name) },
      response.parsed_body
    )
    assert_equal @videos.url, new_url
  end

  test ":update endpoint updates an existing Resource's tags" do
    old_tags = 'that, this'
    new_tags = 'nada'
    guides = build(:resource, name: 'Free guides')
    guides.tag_list.add old_tags, parse: true
    guides.save

    assert_equal guides.tags.map(&:name).sort.join(', '), old_tags

    params = {
      id: guides.id,
      name: guides.name,
      url: guides.url,
      category: guides.category,
      language: guides.language,
      paid: guides.paid,
      tags: new_tags
    }

    put api_v1_resource_url(guides.id), headers: @headers, params: params, as: :json

    guides.reload
    assert_equal response.status, 200
    assert_equal(
      { 'resource' => guides.id, 'tags' => guides.tags.map(&:name) },
      response.parsed_body
    )
    assert_equal guides.tags.map(&:name).join, new_tags
  end

  test ':destroy endpoint destroys an existing Resource' do
    params = {
      id: @videos.id,
      name: @videos.name,
      url: @videos.url,
      category: @videos.category,
      language: @videos.language,
      paid: @videos.paid
    }

    delete api_v1_resource_url(@videos.id), headers: @headers, params: params, as: :json

    assert_equal response.status, 200
    assert_equal 1, Resource.count
  end
end
