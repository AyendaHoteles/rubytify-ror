require "yaml"
require "net/http"
require "rspotify"

file = "artists_respald.yml"

Song.destroy_all
Album.destroy_all
Artist.destroy_all

namespace :import do
  task artists: :environment do
    artists = YAML.load_file(file)
    array = artists["artists"].split(", ")
    array.each do |artist_name|
      spotify_artist = find_artist(artist_name)
      local_artist = save_artist(spotify_artist)
      save_artist_albums(local_artist, spotify_artist)
    end
  end

  task genres: :environment do
    Artist.all.each do |artist|
      byebug
      artist.genres
    end
  end
end

def find_artist(artist_name)
  RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
  array_of_similars = RSpotify::Artist.search(artist_name)
  find_the_exact_coincidence(array_of_similars, artist_name)
end

def find_the_exact_coincidence(artists, artist_name)
  artists.select {|artist| artist.name == artist_name }[0]
end

def save_artist(artist)
  instance = Artist.new(name: artist.name,
    image: artist.images[0]["url"],
    popularity: artist.popularity,
    spotify_url: artist.external_urls["spotify"],
    spotify_id: artist.id)
  instance.genres = artist.genres
  instance.save!
  p "#{artist.name} Guardado"
  instance
end

def save_artist_albums(local_artist, spotify_artist)
  spotify_artist.albums.each do |album|
    instance = store_album(album, local_artist)
    p "    -Album de #{local_artist.name} - #{album.name}"
    save_album_songs(instance, album)
  end
end

def store_album(album, local_artist)
  instance = Album.new(
    name: album.name,
    image: album.images[0]["url"],
    spotify_url: album.external_urls["spotify"],
    total_tracks: album.total_tracks,
    spotify_id: album.id,
    artist_id: local_artist.id
  )
  instance.save!
  instance
end

def save_album_songs(local_album, spotify_album)
  spotify_album.tracks.each do |song|
    instance = Song.new(
      name: song.name,
      spotify_url: song.external_urls["spotify"],
      preview_url: song.preview_url,
      duration_ms: song.duration_ms,
      explicit: song.explicit,
      spotify_id: song.id,
      album_id: local_album.id
    )
    instance.save!
    p "        * #{song.name}"
  end
end
