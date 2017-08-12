module Api
  module V1
    class EventsController < ApplicationController
      def index
        render json: Meetup.new.event_details_by_group
      end

    end
  end
end