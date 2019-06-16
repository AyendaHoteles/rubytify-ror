class Album < ApplicationRecord
  validates :name, presence: true
  validates :spotify_id, presence: true
  validates :spotify_url, presence: true

  belongs_to :artist
  has_many :songs    
end
