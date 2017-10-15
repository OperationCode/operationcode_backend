module Api
  module V1
    class TeamMembersController < ApiController
      before_action :authenticate_user!, except: :index

      def index
        render json: TeamMember.all, status: :ok
      end

      def create
        team_member = TeamMember.create! team_member_params

        render json: { team_member: team_member.id }, status: :created
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def update
        team_member = TeamMember.find params[:id]

        team_member.update! team_member_params
        render json: { status: :ok }
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def destroy
        team_member = TeamMember.find params[:id]

        team_member.destroy!
        render json: { status: :ok }
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

    private

      def team_member_params
        params.permit(:name, :role)
      end
    end
  end
end
