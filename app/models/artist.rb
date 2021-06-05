class Artist < ApplicationRecord
  has_many :albums, dependent: :delete_all
  has_many :songs, through: :albums
end
