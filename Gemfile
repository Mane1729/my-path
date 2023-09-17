source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "bootsnap", require: false
gem 'graphql'
gem "importmap-rails"
gem "jbuilder"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem 'pycall'
gem 'rack-cors'
gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "ruby-openai"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'pry', '~> 0.13.1'
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem 'rails-controller-testing'
  gem 'shoulda', '~> 3.5'
  gem 'faker'
end

group :development do
  gem "web-console"
  gem 'graphiql-rails'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
