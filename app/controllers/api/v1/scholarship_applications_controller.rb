module Api
  module V1
    class ScholarshipApplicationsController < ApplicationController
      respond_to :json

      def create
        @scholarship_application = ScholarshipApplication.new(reason: params[:reason], terms_accpeted: params[:terms_accepted], scholarship_id: params[:scholarship_id], user_id: current_user.id)
        if @scholarship_application.save
          render json: { redirect_to: '/success' }
        else
          render json: { errors: @scholarship_application.errors.values }, status: :bad_request
        end
      end
    end
  end
end
