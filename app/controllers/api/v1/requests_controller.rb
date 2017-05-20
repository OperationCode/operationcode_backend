module Api
  module V1
    class RequestsController < ApplicationController
      before_action :authenticate_user!

      def index
        render json: Request.unclaimed.order('created_at DESC')
      end

      def create
        @request = current_user.requests.create(request_params)
        render json: @request
      end

      def show
        render json: Request.unclaimed.find_by(id: params[:id])
      end

      private

      def request_params
        params.require(:request)
              .permit(:details, :language,
                      :service_id, :requested_mentor_id)
      end

    end
  end
end
