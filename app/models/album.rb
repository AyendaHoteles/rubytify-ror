class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs

  validates :name, presence: true
  validates :spotify_url, presence: true
  validates :spotify_id, presence: true
end
