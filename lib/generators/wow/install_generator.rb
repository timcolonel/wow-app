require 'rails/generators'
require 'generators/wow/generator_helper'

module Wow
  class InstallGenerator < Rails::Generators::Base
    include Wow::GeneratorHelper
    source_root File.expand_path('../templates', __FILE__)
    desc 'Install local config file'

    def install
      config = {
          database_username: 'root', database_password: '', database_host: '172.0.0.1',
      }
      config.each do |k, v|
        config[k] = ask_for(k.to_s.humanize, v)
      end
      template 'local_env_initializer.yml.erb', 'config/application.yml', config
    end
  end
end