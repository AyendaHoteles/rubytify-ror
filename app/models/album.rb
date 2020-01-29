class Album < ApplicationRecord
  has_many :songs, dependent: :destroy
  belongs_to :artist
  validates :spotify_url, presence: true
end
