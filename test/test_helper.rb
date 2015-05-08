require 'coveralls'
Coveralls.wear!
$:.push File.expand_path('../../lib', __FILE__)

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  ActiveRecord::Migration.maintain_test_schema!


  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
  setup :setup_wow
  teardown :teardown_wow

  def setup_wow
    new_user(:user)
    # @ability = Object.new
    # @ability.extend(CanCan::Ability)
    # @controller.stubs(:current_ability).returns(@ability)
    @request.env['HTTP_REFERER'] = '/back'
    bypass_rescue
  end

  def teardown_wow
    sign_out @user
  end

  # By pass controller rescue
  # More importantly cancancan unauthorized access
  def bypass_rescue
    @controller.extend(BypassRescue)
  end

  def new_user(type)
    sign_out @user unless @user.nil?
    @user = create(type)
    sign_in @user
  end

  # Will assert the response returned the given code as well as checking it's in json format.
  def assert_json_response(response_code)
    assert_response response_code
    begin
      json_response
      assert true
    rescue JSON::ParserError => e
      assert false, e.to_s
    end
  end

  def json_response
    JSON.parse(@response.body, symbolize_names: true)
  end
end


module BypassRescue
  def rescue_with_handler(exception)
    raise exception
  end
end