class Song < ApplicationRecord
  belongs_to :album
  validates :name, :spotify_url, :spotify_id, :duration_ms, presence: true
end
