class Artist < ApplicationRecord
  serialize :genres, Array
  validates :spotify_id, presence: true
end
