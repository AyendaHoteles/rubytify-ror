class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs
  validates :name, :spotify_url, :spotify_id, presence: true
end
