module Api
  module V1
    module Users
      class PasswordsController < ApiController

        # Resets password token and sends reset password instructions by email.
        #
        # @see http://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/Recoverable
        #
        def reset
          user = User.find_by email: params[:email]

          raise "Could not find a user with that email address" unless user.present?
          user.send_reset_password_instructions

          render json: { status: :ok }
        rescue StandardError => e
          render json: { errors: e.message }, status: :unprocessable_entity
        end
      end
    end
  end
end
