require 'test_helper'

class Api::V1::PackagesControllerTest < ActionController::TestCase
  test 'index should return json' do
    get :index
    assert_json_response :success
  end

  test 'test pagination' do
    FactoryGirl.create_list(:package, 3)
    get :index, per_page: 2
    assert_json_response :success
    json = json_response
    assert_equal 2, json.size

    get :index, per_page: 2, page: 2
    assert_json_response :success
    json = json_response
    assert_equal 1, json.size
  end

  test 'should get existing package' do
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
    authors = [{name: 'Author 1', email: Faker::Internet.email}, {name: 'Author 2', email: Faker::Internet.email}]
    assert_difference 'Package.count' do
      post :create, package.merge(authors: authors)
      assert_json_response :success
    end
    json = json_response
    assert_not_nil json[:id]
    package.each do |k, v|
      assert_equal package[k], v
    end

    assert_not_nil json[:authors]
    assert_equal authors.size, json[:authors].size
    authors.each_with_index do |author_hash, i|
      assert_equal author_hash[:name], json[:authors][i][:name]
      assert_equal author_hash[:email], json[:authors][i][:email]
    end
  end

  test 'should update package' do
    package = FactoryGirl.create(:package)
    new_package = {name: Faker::App.name,
                   homepage: Faker::Internet.url,
                   short_description: Faker::Lorem.sentence,
                   description: Faker::Lorem.paragraph}
    authors = [{name: 'Author 1', email: Faker::Internet.email}, {name: 'Author 2', email: Faker::Internet.email}]
    post :update, new_package.merge(id: package.id, authors: authors)
    assert_json_response :success
    json = json_response
    assert_equal package.id, json[:id]
    new_package.each do |k, v|
      assert_equal new_package[k], v
    end

    assert_not_nil json[:authors]
    assert_equal authors.size, json[:authors].size
    authors.each_with_index do |author_hash, i|
      assert_equal author_hash[:name], json[:authors][i][:name]
      assert_equal author_hash[:email], json[:authors][i][:email]
    end
  end

  test 'update package without authors params should keep existing authors' do
    package = FactoryGirl.create(:package)
    authors = package.authors.to_a
    new_package = {name: Faker::App.name}
    post :update, new_package.merge(id: package.id)
    assert_json_response :success
    json = json_response

    assert_not_nil json[:authors]
    assert_equal authors.size, authors.size
    authors.each_with_index do |author, i|
      assert_equal author.name, json[:authors][i][:name]
      assert_equal author.email, json[:authors][i][:email]
    end
  end


  test 'should destroy package' do
    package = FactoryGirl.create(:package)
    assert_difference 'Package.count', -1 do
      post :destroy, id: package.id
    end
  end
end
