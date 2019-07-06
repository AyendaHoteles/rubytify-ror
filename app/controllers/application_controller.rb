# frozen_string_literal: true

# Base application controller class
class ApplicationController < ActionController::API
  include NotFoundHandler
end
