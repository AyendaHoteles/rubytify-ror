class Song < ApplicationRecord
    belongs_to :album
    validates_presence_of :name, :spotify_url, :preview_url, :duration_ms, :explicit, :spotify_id
end
