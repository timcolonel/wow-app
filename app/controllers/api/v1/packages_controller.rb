class Api::V1::PackagesController < Api::V1::BaseController

  def index
    render :index
  end

  def create
    authors = params[:authors]
    super
  end

  private

  def package_params
    params.permit(:name, :short_description, :homepage, :description, :authors).merge(user_id: current_user.id)
  end

  def query_params
    params.permit(:name)
  end
end