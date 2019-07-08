# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails'

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end

require 'rspec/rails'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include RequestSpecHelper, type: :request
  config.include Tasks, type: :task

  config.define_derived_metadata(file_path: %r{/spec/tasks/}) do |metadata|
    metadata[:type] = :task
  end

  config.before(:suite) do
    Rails.application.load_tasks
  end

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.infer_base_class_for_anonymous_controllers = false
end
