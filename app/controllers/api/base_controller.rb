module Api
  class BaseController < ApplicationController
    respond_to :json, :xml
    acts_as_token_authentication_handler_for User
  end
end