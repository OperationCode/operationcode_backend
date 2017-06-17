module Api
  module V1
    class SessionsController < Devise::SessionsController
      respond_to :json
      before_action :set_default_response_format

      def create
        Rails.logger.debug 'In Create'
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        render json: { token: resource.token,
                       user: UserSerializer.new(current_user) }
      end

      def set_default_response_format
        request.format = 'json'
      end

    end
  end
end
