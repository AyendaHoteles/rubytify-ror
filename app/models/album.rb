class Album < ApplicationRecord
    validates :name, :image, :spotify_url, :total_tracks, :spotify_id, presence: true
    belongs_to :artist
    has_many :songs
end
