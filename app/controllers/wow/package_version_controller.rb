class Wow::PackageVersionController < ApplicationController
  def index
  end

  def new

  end

  def create
    file = params[:file]
    if file.nil?
      render json: {success: false}
    else
      begin
        Wow::PackageVersion.create_from_file(current_user, file)
      rescue Wow::Error => e
        render :json => {success: false, :message => e.message}
      else
        render :json => {success: true}
      end
    end
  end
end
