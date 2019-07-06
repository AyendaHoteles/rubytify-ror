# frozen_string_literal: true

# Artist class
#
# NOTES:
#
# - Has many images.
class Artist < ApplicationRecord
  has_many :images, as: :owner, dependent: :destroy
end
