class Wow::PackagesController < ApplicationController

  def index

  end

  def new

  end

  def create
    package = Wow::Package.new(package_params)
    render json: params.as_json
  end

  def edit

  end

  def update

  end

  def destroy

  end

  def package_params
    params.permit(:name, :description)
  end
end
