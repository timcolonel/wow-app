class Api::V1::Packages::PlatformsController < Api::V1::BaseController
  model_name = 'Package::Platform'

  def self.model_name
    puts 'awdwajdoiajwo'
    'Package::Platform'
  end

  def platform_params
    params.permit(:name)
  end

  def query_params
    params.permit(:name)
  end
end
