module Api
  module V1
    class SquadsController < ApiController
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

      def show
        @squad = Squad.find(params[:id])
        authorize @squad
        render json: @squad
      end

      def join
        @squad = Squad.find(params[:id])
        authorize @squad
        @squad.add_member(current_user)
        render json: @squad
      end

      private

      def squad_params
        params.require(:squad)
              .permit(:name, :leader_id, :description,
                      :minimum, :maximum,
                      :skill_level, :activities,
                      :end_condition)
      end

    end
  end
end
