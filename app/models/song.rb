class Song < ApplicationRecord
    validates :name, :spotify_url, :preview_url, :duration_ms, :explicit, :spotify_id, presence:true

    belongs_to :album
end
