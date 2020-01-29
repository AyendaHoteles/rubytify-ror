class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  serialize :genres, Array
  validates :spotify_id, presence: true
end
