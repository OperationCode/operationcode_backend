require 'test_helper'

class Api::V1::VotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
    @headers = authorization_headers @user
    @resource = create :resource
  end

  test ':create endpoint creates a new Vote' do
    params = {
      user_id: @user.id,
      resource_id: @resource.id
    }

    post api_v1_resource_votes_url(@resource), headers: @headers, params: params, as: :json

    vote = Vote.first
    assert_equal({ 'vote' => vote.id }, response.parsed_body)
  end

  test 'User cannot create more than one Vote for a given Resource' do
    new_resource = create :resource
    create :vote, user: @user, resource: new_resource
    vote = create :vote, user: @user, resource: @resource
    assert_equal 2, @user.votes.count

    params = {
      user_id: @user.id,
      resource_id: @resource.id
    }

    post api_v1_resource_votes_url(@resource), headers: @headers, params: params, as: :json

    assert_equal 422, response.status
    assert_equal({ 'errors' => 'Validation failed: User has already voted for this resource' }, response.parsed_body)
    assert_equal 2, @user.votes.count
  end

  test ':destroy endpoint destroys an existing Vote' do
    vote = create :vote, user: @user, resource: @resource

    params = {
      id: vote.id,
      user_id: vote.user_id,
      resource_id: vote.resource_id
    }

    delete api_v1_resource_vote_url(@resource, vote), headers: @headers, params: params, as: :json

    assert_equal response.status, 200
    assert_equal 0, Vote.count
  end
end
