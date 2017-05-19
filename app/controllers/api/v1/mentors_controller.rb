class Api::V1::MentorsController < ApplicationController
  # TODO - authorization for mentors
  #before_action :authenticate_user!, only: :protected

  def index
    mentors = [
      User.new(id: 1, email: 'alex@rubyforgood.com'),
      User.new(id: 2, email: 'brandon@rubyforgood.com'),
      User.new(id: 3, email: 'mk@rubyforgood.com')
    ]

    render json: mentors
  end

  def create
  end
end
