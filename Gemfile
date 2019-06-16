source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'rails', '~> 5.2.3'

gem 'puma', '~> 3.11'

gem 'pg'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', :require => 'rack/cors'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'bullet'
end

group :development, :test do
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
  gem 'factory_bot_rails', '~> 4.11.1'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'rspec-mocks', '~> 3.8.0'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-rails', '~> 3.8.0'
  gem 'rspec_junit_formatter'
  gem 'shoulda'
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers'
  gem 'simplecov', require: false
  gem 'webmock'
end

group :production do
  gem 'rack-timeout'
end



# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
