class Api::V1::PackagesController < Api::V1::BaseController
  load_and_authorize_resource

  private

  def package_params
    params.permit(:name, :short_description, :homepage, :description, authors: [:name, :email], tags: [])
        .merge(user_id: current_user.id)
  end

  def query_params
    params.permit(:name)
  end
end