class Song < ApplicationRecord
  belongs_to :album

  validates :name,        presence: :true
  validates :spotify_url, presence: :true
  validates :spotify_id,  presence: :true
  validates :duration_ms, presence: :true

  def self.random_by_genre(genre)
    genre_cond = ["? = ANY(genres)", genre]
    if !Artist.exists?(genre_cond)
      raise ActiveRecord::RecordNotFound, "No songs found in the '#{genre}' genre"
    end
    Song.joins(album: :artist).where(genre_cond).order(Arel.sql("RANDOM()")).limit(1)
  end
end
