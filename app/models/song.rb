class Song < ApplicationRecord
  belongs_to :album, optional: true
    validates_presence_of :album_id, :name, :spotify_url, :preview_url, :duration_ms, :explicit, :spotify_id
end
