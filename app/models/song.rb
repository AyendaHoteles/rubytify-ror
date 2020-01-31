class Song < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :spotify_id
  validates_presence_of :spotify_url

  belongs_to :album
end
