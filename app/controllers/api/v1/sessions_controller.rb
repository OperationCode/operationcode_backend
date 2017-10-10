module Api
  module V1
    class SessionsController < Devise::SessionsController
      respond_to :json
      before_action :set_default_response_format
      before_action :authenticate_user!, only: %i[sso]

      def create
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)

        set_sso_response if sso_request?
        @redirect_path ||= '/profile'

        render json: {
          token: resource.token,
          user: UserSerializer.new(current_user),
          redirect_to: @redirect_path
        }
      end

      def sso
        set_sso_response
        render json: { redirect_to: @redirect_path }
      end

      def set_default_response_format
        request.format = 'json'
      end

      private

      def sso_request?
        params[:sso].present? && params[:sig].present?
      end

      def sso_params
        { sso: params[:sso], sig: params[:sig] }
      end

      def set_sso_response
        @sso = Discourse::SingleSignOn.parse(sso_params, Discourse::SingleSignOn::SECRET)
        @sso.email = current_user.email
        @sso.name = current_user.name
        @sso.username = current_user.email
        @sso.external_id = current_user.id
        @sso.custom_fields['verified'] = current_user.verified
        @sso.sso_secret = Discourse::SingleSignOn::SECRET

        @redirect_path = @sso.to_url('https://community.operationcode.org/session/sso_login')
      end
    end
  end
end
