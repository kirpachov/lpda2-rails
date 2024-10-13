source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.8"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

gem "health_check", "~> 3.1.0"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.6"

gem "mobility", "~> 1.2.9"

gem "activerecord-import", "~> 1.5.1"
gem "jwt", "~> 2.7.1"

gem "image_processing", "~> 1.12.2"

# May need to run:
# sudo apt install libglib2.0-0 libglib2.0-dev libpoppler-glib8 libvips libvips-dev
gem "ruby-vips", "~> 2.2.0"

# gem 'exception_notification', '~> 4.5.0'
gem "bcrypt", "~> 3.1.19"
gem "rack-cors", "~> 1.1.1"
gem "redis", "~> 5.0.6"
# gem 'rubyzip', '~> 2.3.2'
gem "down", "~> 5.4.1"
gem "will_paginate", "~> 3.3.0"
# gem 'google_drive', '~> 3.0.7'
gem "mustache", "~> 1.1.1"
# gem 'pundit', '~> 2.3.1'

gem "aws-sdk-s3", "~> 1.167.0"

gem "rotp", "~> 6.3.0"

# gem 'rotp', '~> 6.2.2'
# gem 'jwt', '~> 2.2.3'
# gem 'mail', '~> 2.7.1'
gem "sidekiq", "~> 7.2.4"
gem "sidekiq-cron", "~> 1.11.0"
gem "sidekiq-status", "~> 3.0.3"
gem "faraday", "~> 1.10.3"

gem "active_interaction", "~> 5.2.0"

gem "rubyXL", "~> 3.4.26", require: false

gem "text-table", "~> 1.2.4"

gem "oj", "~> 3.14.3"

# https://activerecord-hackery.github.io/ransack/
gem "mobility-ransack", "~> 1.2.2"

# gem "image_processing", "~> 1.12.2"
# gem "ruby-vips"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

gem "bootsnap", require: false

group :development, :test do
  gem "parallel_tests", "~> 4.5.1"

  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "database_cleaner", "~> 2.0.1", require: false
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails", "~> 6.2.0", require: false
  gem "faker", "~> 3.0.0", require: false
  gem "pry", require: false
  gem "rails-controller-testing", "~> 1.0.5"
  gem "rspec-rails", "~> 6.0.1"
  gem "rubocop", "~> 1.60.2", require: false
  gem "rubocop-factory_bot", "~> 2.25.1", require: false
  gem "rubocop-performance", "~> 1.20.2", require: false
  gem "rubocop-rails", "~> 2.15.0", require: false
  gem "rubocop-rspec", "~> 2.27.1", require: false
  gem "shoulda-matchers", "~> 5.2.0", require: false

  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "guard", "~> 2.18.0"
  gem "guard-rails", "~> 0.8.1"
  gem "guard-rspec", "~> 4.7.3"
  gem "guard-test", "~> 2.0.8"
  gem "launchy", "~> 2.5.2"
  gem "webmock", "~> 3.18.1"
  # This must be the first gem listed
  gem "appmap", "~> 0.99.4"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem "simplecov", "~> 0.22.0", require: false
end
