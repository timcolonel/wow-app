class Api::V1::Packages::PlatformsController < Api::V1::BaseController
  load_and_authorize_resource class: Package::Platform

  def platform_params
    params.permit(:name)
  end
end