class Album < ApplicationRecord
  belongs_to :artist
  has_many   :songs

  validates :name,         presence: :true
  validates :image,        presence: :true
  validates :spotify_url,  presence: :true
  validates :spotify_id,   presence: :true
  validates :total_tracks, presence: :true
end
