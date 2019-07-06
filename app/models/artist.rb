# frozen_string_literal: true

# Artist class
#
# NOTES:
#
# - Has many images.
# - Has albums.
class Artist < ApplicationRecord
  has_many :images, as: :owner, dependent: :destroy
  has_many :albums, dependent: :destroy
end
