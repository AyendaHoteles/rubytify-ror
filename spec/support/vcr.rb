# frozen_string_literal: true

VCR.configure do |config|
  config.cassette_library_dir = 'spec/support/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.ignore_localhost = true
end
