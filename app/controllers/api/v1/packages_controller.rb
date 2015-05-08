class Api::V1::PackagesController < Api::V1::BaseController
  wrap_parameters :package, include: Package.attribute_names.map(&:to_sym).concat([:authors])

  private

  def package_params
    params.permit(:name, :short_description, :homepage, :description, authors: [:name, :email], tags: [])
        .merge(user_id: current_user.id)
  end

  def query_params
    params.permit(:name)
  end
end