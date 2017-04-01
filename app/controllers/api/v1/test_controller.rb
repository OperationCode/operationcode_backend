module Api
  module V1
    class TestController < ApplicationController
      def slack
        SlackTestJob.perform_later
        render json: { status: :ok, message: 'job created' }
      end
    end
  end
end
