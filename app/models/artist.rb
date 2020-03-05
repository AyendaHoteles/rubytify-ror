class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_many :songs, through: :albums

  validates :name, presence: true
  validates :spotify_url, presence: true
  validates :spotify_id, presence: true

  class << self
    def create_from_spotify(name)
      Services::Spotify::Artist.create(name)
    end
  end
end
