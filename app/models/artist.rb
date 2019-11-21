class Artist < ApplicationRecord
    validates :name, :image, :genres, :popularity, :spotify_url, :spotify_id, presence: true
    has_many :albums
end
