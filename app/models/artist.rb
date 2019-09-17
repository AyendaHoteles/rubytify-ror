class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_many :relations, dependent: :destroy
  has_many :genders, through: :relations, dependent: :destroy
  validates_presence_of :name, :image, :popularity, :spotify_url, :spotify_id
end
