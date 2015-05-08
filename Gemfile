source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'figaro'

gem 'mysql2'

gem 'rails_admin'

gem 'devise'

gem 'bootstrap-sass'

gem 'thin'

gem 'tzinfo-data'

gem 'psych'

gem 'slim'
gem 'slim-rails'

gem 'kaminari'

gem 'cancancan', git: 'https://github.com/timcolonel/cancancan.git'

if ENV['WOW']
  gem 'wow', path: ENV['WOW']
else
  gem 'wow', git: 'https://github.com/timcolonel/wow.git'
end

group :development do
  gem 'quiet_assets'
  gem 'better_errors'

end

gem 'factory_girl_rails', group: :test
gem 'faker', group: :test