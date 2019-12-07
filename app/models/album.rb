class Album < ApplicationRecord
  belongs_to :artist, optional: true
  has_many :songs
end
