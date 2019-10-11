class Genre < ApplicationRecord

  def self.genres
    genres_hash = {}
    Artist.all.each do |artist|
      populate_genre_hash(artist, genres_hash)
    end
    genres_hash
  end

  def self.populate_genre_hash(artist, genres_hash)
    artist.genres.each do |genre|
      genre_with_dash = genre.gsub(" ", "-")
      genres_hash[genre_with_dash] = artist.name
    end
  end

  def self.songs_of(artists)
    songs = []
    artists.each do |artist|
      artist = Artist.find_by(name: artist)
      populate_songs_array(artist, songs)
    end
    songs
  end

  def self.populate_songs_array(artist, songs)
    artist.songs.each do |song|
      songs << song
    end
  end
end
