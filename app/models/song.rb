class Song < ApplicationRecord
  has_and_belongs_to_many :artists
  
  belongs_to :album
  belongs_to :genre

  validates :name, :spotify_url, presence: true
end
