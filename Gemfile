# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

ruby '2.7.2'

gem 'puma', '5.4.0'
gem 'rake', '13.0.6'

gem 'sinatra', '2.1.0', require: 'sinatra/base'
gem 'sinatra-contrib', '2.1.0'

gem 'i18n', '1.8.10'
gem 'config', '3.1.0'

gem 'pg', '1.2.3'
gem 'sequel', '5.48.0'

gem 'dry-initializer', '3.0.4'
gem 'dry-validation', '1.7.0'

gem 'activesupport', '6.1.4.1', require: false
gem 'fast_jsonapi', '1.5'

group :test do
  gem 'rspec', '3.10.0'
  gem 'rack-test', '1.1.0'
  gem 'factory_bot', '6.2.0'
  gem 'database_cleaner-sequel', '2.0.0'
end
