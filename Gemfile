# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

ruby '2.7.2'

gem 'puma', '5.4.0'
gem 'rake', '13.0.6'
gem 'pg', '1.2.3'

gem 'sinatra', '2.1.0'
gem 'activerecord', '6.1.4.1'
gem 'sinatra-activerecord', '2.0.23'

gem 'kaminari', '1.2.1', require: false
gem 'fast_jsonapi', '1.5'

group :test do
  gem 'rspec', '3.10.0'
  gem 'rack-test', '1.1.0'
end
