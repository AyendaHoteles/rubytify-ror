class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs, dependent: :destroy

  validates :artist_id, :name, :spotify_id, presence: true
  validates :spotify_id, uniqueness: true
end
