class Album < ApplicationRecord
    validates :name, :image, :spotify_url, :spotify_id, presence: true
    validates :total_tracks, numericality: true
    belongs_to :artist
end
