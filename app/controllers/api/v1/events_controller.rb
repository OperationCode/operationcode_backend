module Api
  module V1
    class EventsController < ApplicationController
      def index
        @meetups = Meetup.new.get_all_meetups 
        render json:@meetups 
      end

    end
  end
end