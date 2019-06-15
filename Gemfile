source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'
gem 'rails', '~> 5.2.3'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'rspotify'
gem 'pg', '~> 1.1', '>= 1.1.4'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.8'
  gem 'wdm', '>= 0.1.0' if Gem.win_platform?
  gem "factory_bot_rails"
  gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
  gem 'database_cleaner'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "figaro"
