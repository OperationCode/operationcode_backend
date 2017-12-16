class SendGridClient::Response
  attr_reader :body, :status_code

  def initialize(response)
    @response = response
    @body = JSON.parse(response.body) unless response.body.blank?
    @status_code = response.status_code
  end

  def successful?
    successful_status_code && successful_error_count
  end

  private

  def successful_status_code
    status_code == '201'
  end

  # Some requests don't return a body so we default to just checking
  # the status code
  #
  def successful_error_count
    return true if body.blank?

    body['error_count'] == 0
  end
end
