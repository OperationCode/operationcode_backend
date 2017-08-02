module Api
  module V1
    class EventsController < ApplicationController
      def index
        @meetups = Meetup.new.get_events
      end

    end
  end
end