class Song < ApplicationRecord
  belongs_to :album
  belongs_to :gender
  validates_presence_of :name, :spotify_url, :preview_url, :duration_ms, :explicit, :spotify_id, :album_id, :gender_id
end
