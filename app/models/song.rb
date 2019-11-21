class Song < ApplicationRecord
  validates :name, :spotify_url, :preview_url, :duration_ms, :spotify_url, :spotify_id, presence: true
  validates :explicit, inclusion: { in: [true, false] }
  belongs_to :album
end
