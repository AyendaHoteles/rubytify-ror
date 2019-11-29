class Artist < ApplicationRecord
    has_many :albums, dependent: :destroy
    has_many :lists
    has_many :genres, through: :lists
end
