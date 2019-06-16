class Song < ApplicationRecord
  validates :name, presence: true
  validates :duration_ms, presence: true
  validates :preview_url, presence: true
  validates :spotify_id, presence: true
  validates :spotify_url, presence: true

  belongs_to :album

  scope :random!,->(albums) { where(album: albums).sample(1) }
end
