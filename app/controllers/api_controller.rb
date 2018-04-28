class ApiController < ActionController::API
  include CanCan::ControllerAdditions
  wrap_parameters format: [:json]

  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = 'You are not authorized to access this resource.'
    render json: { error: exception.message }, status: :forbidden
  end
end
