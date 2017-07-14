class SendGridClient
  LIST_ID = 1581794

  class SendGridClientError < StandardError; end

  def initialize
    @sendgrid = SendGrid::API.new(api_key: api_key)
    self
  end

  def add_user(user)
    Rails.logger.info("Adding user #{user.email} (#{user.id})")
    recipient_id = add_recipient(user.attributes.slice(*User::SENDGRID_ATTRIBUTES))
    add_recipient_to_list(recipient_id)
  rescue => e
    Rails.logger.error "Failed to add user #{user.id}: #{e}"
    Rails.logger.error e.backtrace.join("\n")
  end

  private

  def add_recipient(data)
    response = Response.new(add_recipient_request(data))
    Rails.logger.info("Response: #{response.body}")
    raise(SendGridClientError, response.body) unless response.successful?
    response.body['persisted_recipients']
  end

  def add_recipient_to_list(recipient_id)
    response = Response.new(add_recipient_to_list_request(recipient_id))
    Rails.logger.info("Response: #{response.body}")
    raise(SendGridClientError, response.body) unless response.successful?
    true
  end

  def api_key
    OperationCode.fetch_secret_with(name: :sendgrid_api_key)
  end

  # The method chains in these request methods represents the path of the API request.
  # SendGrid calls this it's Fluent Interface
  # https://github.com/sendgrid/sendgrid-ruby#general-v3-web-api-usage-with-fluent-interface
  def add_recipient_request(data)
    @sendgrid.client.contactdb.recipients.post(request_body: [data])
  end

  def add_recipient_to_list_request(recipient_id)
    @sendgrid.client.contactdb.lists._(LIST_ID).recipients._(recipient_id).post()
  end
end
