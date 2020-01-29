class Album < ApplicationRecord
  belongs_to :artist
  validates :spotify_url, presence: true
end
