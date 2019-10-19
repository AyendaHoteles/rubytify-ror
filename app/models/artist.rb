class Artist < ApplicationRecord
  serialize :genres

  has_many :albums
end
