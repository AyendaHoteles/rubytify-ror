# frozen_string_literal: true

# Base application record class.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
