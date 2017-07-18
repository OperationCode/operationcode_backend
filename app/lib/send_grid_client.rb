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

  # Sends a transactional email with a template, based on the passed in options hash.
  #
  # @param options [Hash] Sample options hash:
  #   {
  #     to: 'tom@gmail.com',
  #     from: 'frank@oc.com',
  #     subject: 'Hello',
  #     user_count: 5,
  #     body: 'Hello world!',
  #     template_id: 'asdfas-123123-asdfasf-2qwerqwe'
  #   }
  # @return [SendGrid::Response] Includes a body and status_code
  # @see https://github.com/sendgrid/sendgrid-ruby/blob/7c8973f7b8de51a98dce73a52138791b19434573/USE_CASES.md#with-mail-helper-class
  #
  def send_email_with_template(options={})
    Rails.logger.info("Sending email to #{options[:to]} at #{Time.current} re: #{options[:subject]}")

    mail = {
      "personalizations" => [
        {
          "to" => [
            {
              "email" => options[:to]
            }
          ],
          "subject" => options[:subject],
          "template_id" => options[:transactional_template_id]
        }
      ],
      "from" => {
        "email" => options[:from]
      },
      "content" => [
        {
          "type" => "text/plain",
          "value" => options[:body]
        }
      ]
    }

    @sendgrid.client.mail._("send").post(request_body: mail)
  rescue => e
    Rails.logger.error "Failed to send email to #{options[:to]} re: #{options[:subject]} due to: #{e}"
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
