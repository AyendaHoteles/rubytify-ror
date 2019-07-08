class Artist < ApplicationRecord
  serialize :genres
  has_many :albums
  serialize :image
end
