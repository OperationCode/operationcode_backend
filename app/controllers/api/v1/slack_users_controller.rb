module Api
  module V1
    class SlackUsersController < ApiController
      before_action :authenticate_py_bot!

      def create
        # TODO: Placeholder for PyBot call to create new record
      end

      def access
        render json: { message: 'You have access!' }, status: :ok
      end

      private

      def authenticate_py_bot!
        auth = JsonWebToken.decode(auth_token)

        if auth['key'] == Rails.application.secrets.py_bot_auth_key
          true
        elsif auth.dig(:errors).present?
          render json: { errors: auth.dig(:errors) }, status: :unauthorized
        else
          render json: { errors: ['Auth token is invalid'] }, status: :unauthorized
        end
      end

      def auth_token
        @auth_token ||= request.headers.fetch('Authorization', '').split(' ').last
      end
    end
  end
end
