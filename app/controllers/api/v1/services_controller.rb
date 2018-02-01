module Api
  module V1
    class ServicesController < ApiController
      before_action :authenticate_user!

      def index
        services = Service.all
        render json: services
      end

    end
  end
end
