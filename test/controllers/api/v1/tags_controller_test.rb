require 'test_helper'

class Api::V1::TagsControllerTest < ActionController::TestCase
  test 'index should return json' do
    get :index
    assert_json_response :success
  end

  test 'should get existing tag' do
    tag = FactoryGirl.create(:tag)
    get :show, id: tag.id
    assert_json_response :success
    json = json_response
    assert_equal tag.id, json[:id]
    assert_equal tag.name, json[:name]
  end
end
