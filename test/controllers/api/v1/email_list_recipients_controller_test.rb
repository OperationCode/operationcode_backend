require 'test_helper'

class Api::V1::EmailListRecipientsControllerTest < ActionDispatch::IntegrationTest
  def setup
    Sidekiq::Testing.fake!
  end

  def teardown
    Sidekiq::Worker.clear_all
  end

  test ":create with a valid email address renders the guest's email address and guest: true" do
    post api_v1_email_list_recipients_path, params: { email: valid_email }, as: :json

    assert JSON.parse(response.body) == { 'email' => valid_email, 'guest' => true }
  end

  test ':create with a valid email address, responds with a status of 201 (created)' do
    post api_v1_email_list_recipients_path, params: { email: valid_email }, as: :json

    assert response.status == 201
  end

  test ':create with a valid email address calls the AddGuestToSendGridJob' do
    post api_v1_email_list_recipients_path, params: { email: valid_email }, as: :json

    assert_equal 1, AddGuestToSendGridJob.jobs.length
    assert_equal [valid_email], AddGuestToSendGridJob.jobs.first['args']
  end

  test ':create with a invalid email address renders an error message' do
    post api_v1_email_list_recipients_path, params: { email: invalid_email }, as: :json

    assert JSON.parse(response.body) == { 'errors' => "Invalid email address: #{invalid_email}" }
  end

  test ':create with an invalid email address does not call the AddGuestToSendGridJob' do
    0.times { AddGuestToSendGridJob.expects(:perform_async) }

    post api_v1_email_list_recipients_path, params: { email: invalid_email }, as: :json
  end
end

def valid_email
  'john@gmail.com'
end

def invalid_email
  'johngmail.com'
end
