class Song < ApplicationRecord
  scope :album_filter, ->(album_id) { where("album_id IN (?)", album_id) }

  validates :name, :spotify_url, :duration_ms, :spotify_url, :spotify_id, presence: true
  validates :explicit, inclusion: { in: [true, false] }
  belongs_to :album
end
