module Api
  module V1
    class SquadsController < ApplicationController
      before_action :authenticate_user!

      def index
        authorize Squad
        render json: Squad.order('created_at DESC')
      end

      def create
        authorize Squad
        @squad = Squad.create(squad_params)

        if mentor_ids = params["squad"]["mentor_ids"]
          @squad.mentors << mentor_ids.map { |id| User.find(id) }
        end

        render json: @squad
      end

      # def show
      #   @request = Request.find_by(id: params[:id])
      #   authorize @request
      #   render json: @request
      # end

      private

      def squad_params
        params.require(:squad)
              .permit(:name, :leader_id, :description,
                      :minimum, :maximum,
                      :skill_level, :activities,
                      :end_condition)
      end

      def squad_mentor_params
        params.require(:squad).permit(mentors_ids: [])
      end

    end
  end
end
