require 'test_helper'

class Wow::PackageVersionControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
