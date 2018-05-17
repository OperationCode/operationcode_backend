class JsonWebToken
  def self.encode(payload, expiration = nil)
    expiration ||= Rails.application.secrets.jwt_expiration_hours

    payload = payload.dup
    payload['exp'] = expiration.to_i.hours.from_now.to_i

    JWT.encode(payload, Rails.application.secrets.jwt_secret)
  rescue => e
    raise "Failed to encode JsonWebToken due to: #{e}"
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, Rails.application.secrets.jwt_secret)

    decoded_token.first
  rescue JWT::ExpiredSignature
    { errors: ['Auth token has expired'], status: 401 }
  rescue JWT::DecodeError
    { errors: ['Invalid auth token'], status: 401 }
  rescue => e
    Rails.logger.debug "Failed to decode token: '#{token}'"
    Rails.logger.debug e
    nil
  end
end
