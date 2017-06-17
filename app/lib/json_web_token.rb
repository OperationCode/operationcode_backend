class JsonWebToken
  def self.encode(payload, expiration = nil)
    expiration ||= Rails.application.secrets.jwt_expiration_hours

    payload = payload.dup
    payload['exp'] = expiration.to_i.hours.from_now.to_i

    JWT.encode(payload, Rails.application.secrets.jwt_secret)
  rescue => e
    Rails.logger.debug "Failed to encode JsonWebToken due to: #{e}"
    nil
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, Rails.application.secrets.jwt_secret)

    decoded_token.first
  rescue => e
    Rails.logger.debug "Failed to decode token: '#{token}'"
    Rails.logger.debug e
    nil
  end
end
