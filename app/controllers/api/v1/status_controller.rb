module Api
  module V1
    class StatusController < ApplicationController
      before_action :authenticate_user!, only: :protected
      def all
        render json: { status: :ok }
      end

      def protected
        render json: { status: :ok, protected: true }
      end
    end
  end
end
