require 'test_helper'

class Api::V1::EmailListRecipientsControllerTest < ActionDispatch::IntegrationTest
  test ":create with a valid email address renders the guest's email address and guest: true" do
    stub_send_grid_job

    post api_v1_email_list_recipients_path, params: { email: valid_email }, as: :json

    assert JSON.parse(response.body) == { 'email' => valid_email, 'guest' => true }
  end

  test ':create with a valid email address, responds with a status of 201 (created)' do
    stub_send_grid_job

    post api_v1_email_list_recipients_path, params: { email: valid_email }, as: :json

    assert response.status == 201
  end

  test ':create with a valid email address calls the AddGuestToSendGridJob' do
    AddGuestToSendGridJob.expects(:perform_later).with(valid_email)

    post api_v1_email_list_recipients_path, params: { email: valid_email }, as: :json
  end

  test ':create with a invalid email address renders an error message' do
    post api_v1_email_list_recipients_path, params: { email: invalid_email }, as: :json

    assert JSON.parse(response.body) == { 'errors' => "Invalid email address: #{invalid_email}" }
  end

  test ':create with an invalid email address does not call the AddGuestToSendGridJob' do
    0.times { AddGuestToSendGridJob.expects(:perform_later) }

    post api_v1_email_list_recipients_path, params: { email: invalid_email }, as: :json
  end
end

def stub_send_grid_job
  AddGuestToSendGridJob.stubs(:perform_later).returns(true)
end

def valid_email
  'john@gmail.com'
end

def invalid_email
  'johngmail.com'
end
