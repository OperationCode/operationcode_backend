module Devise
  module Strategies
    class JsonWebToken < Base
      def valid?
        request.headers['Authorization'].present?
      end

      def authenticate!
        return fail! unless claims
        return fail! unless claims.has_key?('user_id')

        success! User.find_by_id claims['user_id']
      end

      protected

      def claims
        strategy, token = request.headers['Authorization'].split(' ')

        return nil unless valid_strategy?(strategy)

        claim = ::JsonWebToken.decode(token)
        Rails.logger.debug 'Claim decoded'
        claim
      rescue => e
        Rails.logger.debug "Failed to decode token #{token}"
        Rails.logger.debug e
        nil
      end

      def valid_strategy?(strategy)
        (strategy || '').downcase == 'bearer'
      end
    end
  end
end
