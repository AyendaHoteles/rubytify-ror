class Album < ApplicationRecord
  validates :name, presence: true
  validates :spotify_id, presence: true, uniqueness: true
  validates_presence_of :spotify_url, :total_tracks

  belongs_to :artist, validate: true
  has_many :songs
end
