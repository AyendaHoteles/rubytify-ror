class Artist < ApplicationRecord
  # model association
  has_many :albums, dependent: :destroy
  # validation
  validates_presence_of :name, :image, :popularity, :spotify_url, :spotify_id
end
