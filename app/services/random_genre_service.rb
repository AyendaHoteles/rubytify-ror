# frozen_string_literal: true

class RandomGenreService
  attr_reader :genre

  def initialize(genre)
    @genre = genre
  end

  def show
    artists = artists_genre
    return not_found unless artists

    random_song(artists)
  end

  private

  def artists_genre
    Artist.by_genre(genre).select_uuid
  end

  def random_song(artists)
    Song.songs_by_artists(artists).sample
  end

  def not_found
    { status: :not_found }
  end
end
