class Artist < ApplicationRecord
  serialize :genres, Array

  has_many :albums

  validates :name,        presence: :true
  validates :image,       presence: :true
  validates :genres,      presence: :true
  validates :popularity,  presence: :true
  validates :spotify_url, presence: :true
  validates :spotify_id,  presence: :true
end
