class Artist < ApplicationRecord
  has_many :albums
  has_many :songs, through: :albums
end
