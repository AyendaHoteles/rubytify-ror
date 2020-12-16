class Artist < ApplicationRecord
  has_many :albums
  has_many :songs, through: :albums

  validates :name, presence: true
  validates :popularity, presence: true, numericality: {only_integer: true}
  validates :spotify_id, presence: true
end
