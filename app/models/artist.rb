class Artist < ApplicationRecord

  has_many :albums
  has_many :songs
  has_and_belongs_to_many :genres

  validates :spotify_id, presence: true, uniqueness: true

  scope :order_by_popularity, -> { order(popularity: :desc) }

end
