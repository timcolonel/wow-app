class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  rescue_from CanCan::AccessDenied do |e|
    if json_request?
      render json: {message: 'Not authorized!'}, status: :forbidden
    end
  end

  def json_request?
    request.format.json?
  end
end
