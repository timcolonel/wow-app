module Api
  class BaseController < ApplicationController
    respond_to :json, :xml
    acts_as_token_authentication_handler_for User, fallback_to_devise: false

    rescue_from CanCan::AccessDenied do |e|
      render json: {message: 'Not authorized!'}, status: :forbidden
    end

  end
end