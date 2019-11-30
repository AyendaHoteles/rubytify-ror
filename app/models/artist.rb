class Artist < ApplicationRecord
	has_many :albums, dependent: :destroy
	has_many :songs,through: :albums, dependent: :destroy 
end
