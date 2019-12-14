class Song < ApplicationRecord
  belongs_to :album

  validates :name, :spotify_url, :duration_ms, :explicit, :spotify_id, presence: true
end
