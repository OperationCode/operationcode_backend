require 'net/http'

module Slack
  INVITE_PATH = '/api/users.admin.invite'.freeze
  POST_MESSAGE_PATH = '/api/chat.postMessage'.freeze
  USERS_LIST_PATH = '/api/users.list'.freeze
  LOOKUP_BY_EMAIL_PATH = '/api/users.lookupByEmail'.freeze
  BOT_USERNAME = 'OpCodeBot'.freeze

  class Client
    RequestFailed = Class.new(StandardError)
    InviteFailed = Class.new(StandardError)
    PostMessageFailed = Class.new(StandardError)
    FetchUsersListFailed = Class.new(StandardError)
    LookupUserEmailFailed = Class.new(StandardError)

    attr_reader :domain

    def initialize(subdomain:, token:)
      @subdomain = subdomain
      @token = token
      @domain = "#{subdomain}.slack.com"
    end

    def invite(extra_message:, email:, channels: [])
      Rails.logger.info "Inviting user with email '#{email}'"
      body = send_api_request(
        to: INVITE_PATH,
        payload: {
          email:       email,
          channels:    channels.join(','),
          token:       @token,
          set_active:  'true',
          extra_message: extra_message,
          _attempts:   1
        }
      )
      if !(body['ok'] || %w(already_in_team already_invited sent_recently).include?(body['error']))
        raise InviteFailed.new(body.to_s)
      end

      true
    end

    def post_message_to(channel:, with_text:)
      body = send_api_request(
        to: POST_MESSAGE_PATH,
        payload: {
          token:    @token,
          channel:  channel,
          text:     with_text,
          username: BOT_USERNAME
        }
      )

      return true if body['ok'] == true || body['ok'] == 'true'
      raise PostMessageFailed.new(body.to_s)
    end

    def validate_user_email(email:)
      body = send_api_request(
        to: LOOKUP_BY_EMAIL_PATH,
        payload: {
          token:    @token,
          email: email
        }
      )

      raise LookupUserEmailFailed.new(body.to_s) unless body ['ok'] == true || body['ok'] == 'true'
    end

    def fetch_users_list(presence: 0)
      body = send_api_request(
        to: USERS_LIST_PATH,
        payload: {
          token:    @token,
          presence: presence
        }
      )

      return body if body['ok'] == true || body['ok'] == 'true'
      raise FetchUsersListFailed.new(body.to_s)
    end

    private

    def send_api_request(to:, payload:)
      Rails.logger.info "Sending payload '#{payload}' to '#{to}'"
      res = Net::HTTP.start(@domain, 443, use_ssl: true) do |http|
        req = Net::HTTP::Post.new("#{to}?t=#{Time.now.to_i}")
        req.set_form_data payload

        http.request(req)
      end

      raise RequestFailed.new("HTTP status code: #{res.code}") unless res.is_a?(Net::HTTPSuccess)

      JSON.parse(res.body)
    end
  end
end
