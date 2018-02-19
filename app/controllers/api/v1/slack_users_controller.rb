module Api
  module V1
    class SlackUsersController < ApplicationController
      before_action :authenticate_user!, only: [:create]
      before_action :verify_py_bot, only: [:index, :show, :update]

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
        all_users = User.all.map {|user| UserSerializer.new(user).attributes }        
        render json: {users: all_users }, status: 200
      end

      # get a single slack user (specifically want :verified and :slack_name)
      def show
        user = User.by_email.find(params[:email])
        if user 
          render json: UserSerializer.new(user).attributes        
        else
          render json: { error: 'No such email record' }, status: :not_found
        end
      end

      # update a single slack name by email
      def update
        user = User.find(params[:email])
        if user.update(slack_name params[:slack_name])
          render json: { users: UserSerializer.new(user) }, status: 200
        else
          render json: { errors: user.errors.full_messages}, status: 400
        end
      end
    
      private

      def verify_py_bot

          unless request.headers['auth_key'] == ENV['pybot_token']
            render json: {error: 'Invalid token request '}, status: 500         
          end
      end

    end
  end
end
