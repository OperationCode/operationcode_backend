class ApiController < ActionController::API
  wrap_parameters format: [:json]
  include Pundit
end
