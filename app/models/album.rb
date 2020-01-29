class Album < ApplicationRecord
  has_many :tracks, dependent: :destroy
  belongs_to :artist
  validates :spotify_url, presence: true
end
