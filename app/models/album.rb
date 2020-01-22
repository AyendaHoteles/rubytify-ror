class Album < ApplicationRecord
    belongs_to :artist, optional: true
    has_many :song

    validates :name, presence: true
    validates :image, presence: true
    validates :spotify_url, presence: true
    validates :spotify_id, presence: true
    validates :total_tracks, presence: true
end
