class Artist < ApplicationRecord
    validates :name, :image, :genres, :spotify_url, :spotify_id, presence: true
    validates :popularity, numericality: true
    has_many :albums
end
