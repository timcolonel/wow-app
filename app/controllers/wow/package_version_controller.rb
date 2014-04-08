class Wow::PackageVersionController < ApplicationController
  def index
  end

  def new

  end

  def create
    file = params[:file]
    if file.nil?
      render :json => {:success => false}
    else
      Wow::PackageVersion.create_from_file(current_user, file)
      render :json => {:success => true}
    end
  end
end
