module Api
  module V1
    class StatusController < ApplicationController
      def all
        render json: { status: :ok }
      end
    end
  end
end
