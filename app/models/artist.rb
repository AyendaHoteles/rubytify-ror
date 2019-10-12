class Artist < ApplicationRecord
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :songs
  has_many                :albums

  validates :name, :spotify_url, presence: true
end
