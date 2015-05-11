class Api::V1::TagsController < Api::V1::BaseController
  private

  def tags_params
    params.permit(:name)
  end

  def query_params
    params.permit(:name)
  end
end
