# frozen_string_literal: true

# Artist class
#
# NOTES:
#
# - Has one image.
# - Has albums.
class Artist < ApplicationRecord
  has_one :image, as: :owner, dependent: :destroy
  has_many :albums, dependent: :destroy
end
