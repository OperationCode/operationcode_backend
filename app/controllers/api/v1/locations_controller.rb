module Api
  module V1
    class LocationsController < ApiController
      before_action :set_location, except: :create
      before_action :authenticate_user!

      def create
        location = Location.create!(location_params)

        render json: { location: location.id }, status: :created
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def update
        @location.update!(location_params)

        render json: { status: :ok }
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def destroy
        @location.destroy!

        render json: { status: :ok }
      rescue ActiveRecord::RecordNotDestroyed, NoMethodError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      private

      def set_location
        @location = Location.find_by(id: params[:id])
      end

      def location_params
        params.require(:location).permit(:code_school_id, :va_accepted, :address1, :address2, :city, :state, :zip)
      end
    end
  end
end
