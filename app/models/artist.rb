# frozen_string_literal: true

# Artist class
#
# NOTES:
#
# - Has one image.
# - Has albums.
class Artist < ApplicationRecord
  has_one :image, as: :owner, dependent: :destroy, autosave: true
  has_many :albums, dependent: :destroy

  before_update :delete_cache
  before_destroy :delete_cache

  # Search artists by genre (exact match)
  scope :by_genre, ->(genre_name) {
    where(':genre_name = ANY(genres)', genre_name: genre_name)
  }

  private

  def delete_cache
    Rails.cache.delete("artist/#{id}")
  end
end
