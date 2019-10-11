class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs, dependent: :destroy
  validates :name, :spotify_url, :spotify_id, presence: true
end
