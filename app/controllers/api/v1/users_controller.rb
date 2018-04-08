module Api
  module V1
    class UsersController < ApiController
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
