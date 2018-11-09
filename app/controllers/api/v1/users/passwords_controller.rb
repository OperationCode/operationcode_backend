module Api
  module V1
    module Users
      class PasswordsController < ApiController

        # Resets password token and sends reset password instructions by email.
        #
        # @see http://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/Recoverable
        #
        def forgot
          user = User.find_by email: params[:email]
          raise 'Could not find a user with that email address' unless user.present?
          user.generate_password_token!
          user.send_reset_password_instructions
          render json: { status: :ok }
        rescue StandardError => e
          render json: { errors: e.message }, status: :unprocessable_entity
        end

        def reset
          token = params[:reset_password_token].to_s
          user = User.with_reset_password_token(token)

          user.reset_password_token
          if user.present? && user.password_token_valid?
            if user.reset_password!(params[:password])
              render json: { status: 'ok' }, status: :ok
            else
              render json: { error: user.errors.full_messages }, status: :unprocessable_entity
            end
          else
            render json: { error: ['Link not valid or expired. Try generating a new link.'] }, status: :not_found
          end
        end

        def update
          render json: { error: 'Password not present' }, status: :unprocessable_entity unless params[:password].present

          if current_user.reset_password(params[:password])
            render json: { status: 'ok' }, status: :ok
          else
            render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
