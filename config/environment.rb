# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# setup logger in the project
Rails.logger = Logger.new(STDOUT)
config.logger = ActiveSupport::Logger.new("log/#{Rails.env}.log")
Rails.logger.datetime_format = "%Y-%m-%d %H:%M:%S"