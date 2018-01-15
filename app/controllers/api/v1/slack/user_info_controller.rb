module Api
  module V1
    module Slack
      class UserInfoController < ApplicationController
        before_action VerifyRequest 
 
        # get all users 
        def index
          render json: Users.all
        end

        # get a single slack user (specifically want :verified and :slack_name)
        def show
          user = Users.find_by(email: params[:email])
          if user 
            render json: user 
          else
            render json: { error: 'No such email record' }, status: :not_found
          end
        end

        # update a single slack name by email
        def update
          user = User.find(params[:email])
          if user.update(:slack_name params[:slack_name])
            render json: user 
          else
            render json: { errors: user.errors.full_messages }
          end
        end
      end 
      
      class VerifyRequest
          def self.before(controller)
            unless controller(:auth_key == ENV['pybot_token'] )
              render json: {error: 'Invalid token request '}, status: 500         
            end
          end
      end
        

    end
  end
end
