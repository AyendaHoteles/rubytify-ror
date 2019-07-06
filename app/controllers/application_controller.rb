# frozen_string_literal: true

# Base application controller class.
# Every API controller needs to inherit from this base class.
class ApplicationController < ActionController::API
  include NotFoundHandler
end
