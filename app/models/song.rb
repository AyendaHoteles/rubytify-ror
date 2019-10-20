class Song < ApplicationRecord
  belongs_to :album
  validates :spotify_id, uniqueness: true
  validates_presence_of :name, :preview_url, :duration_ms, :spotify_url, :spotify_id
  validates :explicit, inclusion: { in: [true, false] }
  validates :explicit, exclusion: { in: [nil] }
end
