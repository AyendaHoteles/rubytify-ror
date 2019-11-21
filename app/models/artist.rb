class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_many :songs, through: :albums

  accepts_nested_attributes_for :albums
end
