class Song < ApplicationRecord
  belongs_to :album
  has_many :lists
  has_many :genres, through: :lists
end
