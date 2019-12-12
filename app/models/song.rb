class Song < ApplicationRecord
  belongs_to :album

  validates :name,        presence: :true
  validates :spotify_url, presence: :true
  validates :spotify_id,  presence: :true
  validates :preview_url, presence: :true
  validates :duration_ms, presence: :true

  def self.random_by_genre(genre)
    Song.
      joins(album: :artist).
      where("? = ANY(genres)", genre).
      order("RANDOM()").
      limit(1)
  end
end
