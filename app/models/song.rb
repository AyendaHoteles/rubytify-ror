# frozen_string_literal: true

class Song < ApplicationRecord
  belongs_to :album

  validates :name,
            :preview_url,
            :spotify_url,
            :spotify_id, presence: true

  scope :songs_by_artists, ->(artists) {
    joins(:album).where(albums: { artist_id: artists })
  }
end
