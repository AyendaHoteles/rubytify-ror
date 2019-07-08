# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'dalli', '~> 2.7', '>= 2.7.10'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'puma_worker_killer'
gem 'rack-cors'
gem 'rails', '~> 5.2.3'
gem 'rspotify', '~> 2.6'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', '~> 2.7', '>= 2.7.4'
  gem 'massa', '~> 0.5.0'
  gem 'rspec-rails', '~> 3.8'
  gem 'rspec-rails-swagger', '~> 0.1.5'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', '~> 0.72.0', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner', '~> 1.7'
  gem 'shoulda-matchers', '~> 4.1'
  gem 'simplecov', '~> 0.17.0', require: false
  gem 'vcr', '~> 5.0'
  gem 'webmock', '~> 3.6'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
