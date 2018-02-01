module Api
  module V1
    class ScholarshipApplicationsController < ApiController
      def create
        current_user.scholarship_applications.create! scholarship_application_params

        render json: { redirect_to: '/success' }, status: :created
      rescue StandardError => e
        render json: { error: e.message }, status: :bad_request
      end

      private

      def scholarship_application_params
        params.require(:scholarship_application).permit(:reason, :terms_accepted, :scholarship_id)
      end
    end
  end
end
