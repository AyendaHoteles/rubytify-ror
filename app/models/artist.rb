class Artist < ApplicationRecord
    serialize :genres

    has_many :albums
    has_many :songs, :through :albums
end
