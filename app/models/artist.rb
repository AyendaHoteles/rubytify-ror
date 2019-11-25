class Artist < ApplicationRecord
    validates :name, :image, :genres, :popularity, :spotify_url, :spotify_id, presence:true

    has_many :albums

    scope :order_by_popularity, -> { order(popularity: :desc) }

end
