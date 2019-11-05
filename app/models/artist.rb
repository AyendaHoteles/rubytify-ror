class Artist < ApplicationRecord
  has_many :albums
  serialize :genres, Array #Here we specify that this field is an array within the database
end
