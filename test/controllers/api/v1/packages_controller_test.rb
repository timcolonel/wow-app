require 'test_helper'

class Api::V1::PackagesControllerTest < ActionController::TestCase
  test 'index should return json' do
    get :index
    assert_json_response :success
  end

  test 'should get new package' do
    package = FactoryGirl.create(:package)
    get :show, id: package.id
    assert_json_response :success
    json = json_response
    assert_equal package.id, json[:id]
    assert_equal package.name, json[:name]
  end

  test 'should create a new package' do
    package = {name: Faker::App.name,
               homepage: Faker::Internet.url,
               short_description: Faker::Lorem.sentence,
               description: Faker::Lorem.paragraph}
    post :create, package
    assert_json_response :success
    json = json_response
    assert_not_nil json[:id]
    package.each do |k, v|
      assert_equal package[k], v
    end
  end
end
