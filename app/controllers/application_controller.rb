class ApplicationController < ActionController::Base
  wrap_parameters format: [:json]
  include Pundit
end
