module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!, only: %i[update]

      def index
        render json: { user_count: User.count }, status: :ok
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def create
        user = User.new(user_params)

        if user.save
          UserMailer.welcome(user).deliver unless user.invalid?
          sign_in(user)
          render json: { token: user.token }
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def update
        if current_user.update_attributes(user_params)
          render json: current_user
        else
          render json: current_user.errors, status: :unprocessable_entity
        end
      end

      # exist
      #
      # When given a user's email, checks if that user is already registered in the database
      # and sends the proper redirect url to the frontend accordingly. Called when logging in
      # via social media.
      # @param params The data passed in from the frontend, from which [:user][:email] (the user's email) is extracted. Expecting :user in params with parameter :email inside.

      def exist
        user = User.find_by(email: params[:user][:email])
        Rails.logger.info "************ user is = #{user}"
        @redirect_path = '/profile' #change this to actually redirect to the social login function
        unless user
          @redirect_path = '/additional_info'
        end
        Rails.logger.info "!!!!!!!!!!!! path is #{@redirect_path}"
        render json: { redirect_to: @redirect_path }
      end

      # social
      #
      # When using social logins, creates the user in the database if necessary, then logs them in
      # and sends the proper redirect url to the frontend accordingly.

      def social
        Rails.logger.info "************ got to create = #{params.inspect}"
          path = ''
          set_social_user
          Rails.logger.info "************ here!"
          Rails.logger.info "************ user is = #{@user.email}"

          if @user.save
            UserMailer.welcome(@user).deliver unless @user.invalid?
            Rails.logger.info "************ success!"
            Rails.logger.info "************ resource = #{@user.zip}"
            #sign_in_and_redirect @user, event: :authentication
            #resource = warden.authenticate!(params)
            sign_in @user, event: :authenticate_user
            render json: {
              token: @user.token,
              user: UserSerializer.new(current_user),
              redirect_to: @redirect_path
            }
            Rails.logger.info "************ path: #{@redirect_path}"
            #redirect_to new_user_session_url
            #sign_in_and_redirect @user, event: :authentication
          else
            Rails.logger.info "************ failure"
            redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
          end
      end

      def verify
        verified = IdMe.verify! params[:access_token]

        Rails.logger.debug "Got verified status '#{verified}'"
        Rails.logger.debug "Updating user'#{current_user.inspect}'"
        current_user.update_attribute(:verified, verified)
        Rails.logger.debug "Updating user'#{User.last.inspect}'"
        render json: { status: :ok, verified: verified }
      rescue => e
        Rails.logger.debug "When verifying User id #{User.last.id} through ID.me, experienced this error: #{e}"
        render json: { status: :unprocessable_entity }, status: :unprocessable_entity
      end

      def by_location
        render json: { user_count: UsersByLocation.new(params).count }, status: :ok
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      private

      # set_social_user
      #
      # When given a user's calls the method to create the user if needed, which returns the user and the redirect path.
      # @param params The data passed in from the frontend, from which the user's data is extracted. Expecting :user in params.

      def set_social_user
        arr = User.from_social(params[:user])
        @user = arr[0]
        @redirect_path = arr[1]
      end

      def user_params
        params.require(:user).permit(
          :email,
          :zip,
          :password,
          :mentor,
          :slack_name,
          :first_name,
          :last_name,
          :bio,
          :verified,
          :state,
          :address1,
          :address2,
          :username,
          :volunteer,
          :branch_of_service,
          :years_of_service,
          :pay_grade,
          :military_occupational_specialty,
          :github,
          :twitter,
          :linked_in,
          :employment_status,
          :education,
          :company_role,
          :company_name,
          :education_level,
          :scholarship_info,
          interests: []
        )
      end
    end
  end
end
