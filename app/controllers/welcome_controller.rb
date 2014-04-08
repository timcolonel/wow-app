class WelcomeController < ApplicationController
  def index
  end

  def authenticity_token
    render :json => form_authenticity_token
  end
end
