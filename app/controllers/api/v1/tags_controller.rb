class Api::V1::TagsController < Api::V1::BaseController
  load_and_authorize_resource

  private
  def tag_params
    params.permit(:name)
  end

  def query_params
    params.permit(:name)
  end
end
