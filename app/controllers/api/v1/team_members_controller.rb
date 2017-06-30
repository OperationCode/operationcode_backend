module Api
  module V1
    class TeamMembersController < ApplicationController

      # :GET, "/api/v1/team_members", "Returns JSON index of all TeamMembers"
      def index
        render json: TeamMember.all
      end

      # :POST, "/api/v1/team_members", "Creates a new TeamMember"
      def create
        team_member = TeamMember.create! team_member_params

        render json: { team_member: team_member.id }
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      # :PUT, "/api/v1/team_members/:id", "Updates an existing TeamMember"
      def update
        team_member = TeamMember.find params[:id]

        team_member.update! team_member_params
        render json: { status: :ok }
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      # :DELETE, "/api/v1/team_members/:id", "Deletes an existing TeamMember"
      def destroy
        team_member = TeamMember.find params[:id]

        team_member.destroy!
        render json: { status: :ok }
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

    private

      def team_member_params
        params.require(:team_member).permit(:name, :role)
      end
    end
  end
end
