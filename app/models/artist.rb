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

  # Search artists by genre (exact match)
  scope :by_genre, ->(genre_name) {
    where(':genre_name = ANY(genres)', genre_name: genre_name)
  }
end
