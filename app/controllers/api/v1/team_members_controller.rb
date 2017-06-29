module Api
  module V1
    class TeamMembersController < ApplicationController
      def index
        render json: TeamMember.all
      end
    end
  end
end
