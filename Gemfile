source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.0'
gem 'rails', '~> 5.2.3'
gem 'sqlite3', group: :development
gem 'rails_12factor', group: :production
gem 'puma', '~> 3.12'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'simple_form', '~> 4.0', '>= 4.0.1'
gem 'jquery-rails'
gem 'devise', '~> 4.5'
gem 'paperclip', '~> 6.1'
gem 'jquery-turbolinks'
gem 'paperclip-compression'
gem 'notifications', '~> 0.6.0'
gem 'acts_as_votable', '~> 0.11.1'
gem 'toastr-rails'
gem 'trix-rails', require: 'trix'
gem 'impressionist', '~> 1.6', '>= 1.6.1'
gem 'acts_as_follower', github: 'tcocca/acts_as_follower', branch: 'master'
gem 'client_side_validations', '~> 11.1', '>= 11.1.3'
gem 'friendly_id', '~> 5.2.0'
gem 'searchkick'
gem 'jquery-atwho-rails'
gem 'materialize-sass', '~> 1.0.0'
gem 'material_icons'
gem 'pwa'
gem 'serviceworker-rails'


# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
gem 'mini_magick', '~> 4.8'
gem 'mailcatcher'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
