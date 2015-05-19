class Api::V1::PackagesController < Api::V1::BaseController
  load_and_authorize_resource
  def create
    super
  end
  private

  def package_params
    result = params.permit(:name, :short_description, :homepage, :description, authors: [:name, :email], tags: [])
    result.merge(user_id: current_user.id) if user_signed_in?
  end

  def query_params
    params.permit(:name)
  end
end