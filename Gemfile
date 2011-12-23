source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'json'
gem 'jquery-rails'
gem 'heroku'
gem 'dragonfly'
gem 'rack-cache', :require => 'rack/cache'
gem 'psych'
gem 'newrelic_rpm'
gem 'airbrake'
gem 'therubyracer'
gem 'httparty'
gem 'logglier'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

group :production do
  gem 'pg'
  gem 'fog'
end

group :development do
#  gem 'yard'
#  gem 'redcarpet' # Used by yard for markdown documents
end

group :development, :test do
  gem 'rspec-rails'
  gem 'pry'
  gem 'sqlite3'
end

group :test do
  gem 'rspec'
  gem 'shoulda-matchers'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'webmock'
  gem 'rb-fsevent', :require => false
  gem 'guard-rspec'
  gem 'simplecov', :require => false
  gem 'vcr'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

