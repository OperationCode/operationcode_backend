module Api
  module V1
    class VotesController < ApiController
      before_action :authenticate_user!

      def create
        vote = current_user.votes.create! resource_id: params[:resource_id]

        render json: { vote: vote.id }, status: :ok
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def destroy
        vote = Vote.find params[:id]

        vote.destroy!
        render json: { status: :ok }
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end
    end
  end
end
