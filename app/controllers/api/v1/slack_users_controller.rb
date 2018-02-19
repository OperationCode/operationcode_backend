module Api
  module V1
    class SlackUsersController < ApplicationController
      before_action :authenticate_user!, only: [:create]
      before_action :verify_py_bot!, only: [:index, :show, :update]

      def create
        raise "User id #{current_user.id} does not have a saved email address." unless current_user.email.present?

        SlackJobs::InviterJob.perform_now current_user.email

        render json: { status: :ok }
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      ## pybot interaction methods ##
      # get all users 
      def index
        render json: UserSerializer(Users)
      end

      # get a single slack user (specifically want :verified and :slack_name)
      def show
        user = Users.find_by(email: params[:email])
        if user 
          render json: user.attributes
        else
          render json: { error: 'No such email record' }, status: :not_found
        end
      end

      # update a single slack name by email
      def update
        user = User.find(params[:email])
        if user.update(slack_name params[:slack_name])
          render json: { UserSerializer(user) }, status: 200
        else
          render json: { errors: user.errors.full_messages}, status: 400
        end
      end
    
      private

      def verify_py_bot
          unless controller(:auth_key == ENV['pybot_token'] )
            render json: {error: 'Invalid token request '}, status: 500         
          end
      end

    end
  end
end
