class Album < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :spotify_id
  validates_presence_of :spotify_url

  belongs_to :artist
  has_many :songs
end
