class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs

  validates :name, presence: true
  validates :total_tracks, presence: true, numericality: {only_integer: true}
  validates :spotify_id, presence: true
  validates_associated :artist
end
