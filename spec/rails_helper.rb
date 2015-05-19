# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

class ControllerActionTester
  def initialize(binding, action, cls)
    @binding = binding
    @action = action
    @cls = cls
  end

  def cls
    @cls
  end

  def action
    @action
  end

  def with(&params_block)
    @params_block = params_block
    tester = self
    @binding.it 'respond successfully with 201' do
      post tester.action, instance_eval(&params_block)
      expect(response).to be_success
      expect(response).to have_http_status(201)
    end

    @binding.it 'return data in json format' do
      post tester.action, instance_eval(&params_block)
      expect(response).to return_json
    end

    @binding.it "add a new #{@cls}" do
      expect { post tester.action, instance_eval(&params_block) }.to change(tester.cls, :count).by(1)
    end
    self
  end

  def and_compare_params(&block)
    tester = self
    @binding.it 'check the params are attributed' do
      test_params = instance_eval(&block)
      post tester.action, instance_eval(&tester.params)
      json = json_response
      test_params.each do |key, value|
        expect(json[key]).to eq(value)
      end
    end
    self
  end

  def params
    @params_block
  end
end

module Wow
  module Rspec
    module Helper
      def json_response
        JSON.parse(response.body, symbolize_names: true)
      end
    end

    module Macro
      def test_pagination(action, factory)
        let (:per_page) { 2 }
        let (:record_count) { 3 }
        before do
          FactoryGirl.create_list(factory, record_count)
        end

        it 'get first page' do
          get action, per_page: per_page
          expect(response).to return_json
          expect(json_response).to be_a Array
          expect(json_response.size).to eq(per_page)
        end

        it 'get second and last page' do
          get action, per_page: per_page, page: 2
          expect(response).to return_json
          expect(json_response).to be_a Array
          expect(json_response.size).to eq(record_count - per_page)
        end
      end

      def when_user_signed_in(&block)
        example_group_class = context 'when user is signed in' do
          before do
            @request.env['devise.mapping'] = Devise.mappings[:user]
            @request.env['HTTP_REFERER'] = '/back'
            @user = FactoryGirl.create(:user)
            sign_in @user
          end

          after do
            sign_out @user
            @user = nil
          end
        end
        example_group_class.class_eval &block
      end

      def it_create_a(cls)
        tester = ControllerActionTester.new(self, :create, cls)
        tester
      end
    end
  end
end


RSpec::Matchers.define :return_json do
  match do |actual|
    begin
      JSON.parse(actual.body)
      true
    rescue JSON::ParserError
      false
    end
  end
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.include Wow::Rspec::Helper

  config.extend Wow::Rspec::Macro, type: :controller
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!
end
