class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  validates :name, :popularity, :spotify_url, :spotify_id, presence: true
end
