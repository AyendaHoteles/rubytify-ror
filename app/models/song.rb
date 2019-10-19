class Song < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :album_id }
  validates_presence_of %w[spotify_url spotify_id duration_ms]

  belongs_to :album, validate: true
end
