class SendGridClient
  LIST_ID = 1581794

  class SendGridClientError < StandardError; end

  def initialize
    @sendgrid = SendGrid::API.new(api_key: OperationCode.fetch_secret_with(name: :sendgrid_api_key))
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
    response = Response.new(@sendgrid.client.contactdb.recipients.post(request_body: [data]))
    Rails.logger.info("Response: #{response.body}")
    raise(SendGridClientError, response.body) unless response.successful?
    response.body['persisted_recipients']
  end

  def add_recipient_to_list(recipient_id)
    response = Response.new(@sendgrid.client.contactdb.lists._(LIST_ID).recipients._(recipient_id).post())
    Rails.logger.info("Response: #{response.body}")
    raise(SendGridClientError, response.body) unless response.successful?
    true
  end
end
