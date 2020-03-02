class Song < ApplicationRecord
  belongs_to :album

  validates :name, presence: true
  validates :spotify_url, presence: true
  validates :spotify_id, presence: true
end
