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
          puts user.send_reset_password_instructions
          puts user
          render json: { status: :ok }
        rescue StandardError => e
          puts e.message
          render json: { errors: e.message }, status: :unprocessable_entity
        end

        def reset
          token = params[:reset_password_token].to_s
          puts 'params'
          puts token
          puts params
          user = User.with_reset_password_token(token)
          puts 'here'
          puts user.reset_password_token
          begin
            if user.present? && user.password_token_valid?
              if user.reset_password!(params[:password])
                render json: {status: 'ok'}, status: :ok
              else
                render json: {error: user.errors.full_messages}, status: :unprocessable_entity
              end

            else
              render json: {error:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
            end
          rescue StandardError => e
            puts e.message
          end
        end 
      end
    end
  end
end
