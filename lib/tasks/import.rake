require 'yaml'
require 'rspotify'

namespace :import do
  desc 'Import data from spotify API'
  task artists: :environment do
    file = YAML.load_file('config/import.yml')
    artists = file['artists'].split(', ')

    artists.each do |name|
      artist = find_artist_information(name)

      # Save artist data
      artist_local_id = create_artist_data(artist)

      # Save artist albums data and songs
      create_artist_albums(artist, artist_local_id)
  end
end

private

def find_artist_information(name)
  client_id = Rails.application.credentials.spotify[fe36f195e48447428a88b9e8dce4cde6]
  client_secret = Rails.application.credentials.spotify[bad5f171552842d8b2d86916c2a6ec6d]
  RSpotify.authenticate(client_id, client_secret)

  RSpotify::Artist.search(name).first
end

def create_artist_data(artist)
  artist_data = {
    name: artist.name,
    image: artist.images.first['url'],
    genres: artist.genres,
    popularity: artist.popularity,
    spotify_url: artist.external_urls['spotify'],
    spotify_id: artist.id
  }
  save_artist(artist_data)
end

def save_artist(data)
  Artist.find_or_create_by(spotify_id: data[:spotify_id])
        .update!(data)
  p "Artist: #{data[:name]} updated"
  artist = Artist.find_by(spotify_id: data[:spotify_id])
  artist.id
end

def create_artist_albums(artist, artist_id)
  artist.albums(country: 'CO').each do |album|
    album_data = {
      name: album.name,
      image: album.images.first['url'],
      spotify_url: album.external_urls['spotify'],
      total_tracks: album.total_tracks,
      spotify_id: album.id,
      artist_id: artist_id
    }
    album_id = save_album(album_data)
    create_albums_songs(album, album_id)
  end
end

def save_album(data)
  Album.find_or_create_by(spotify_id: data[:spotify_id])
       .update!(data)
  p "Album: #{data[:name]} updated"
  album = Album.find_by(spotify_id: data[:spotify_id])
  album.id
end

def create_albums_songs(album, album_id)
  album.tracks.each do |song|
    song_data = {
      name: song.name,
      spotify_url: song.external_urls['spotify'],
      preview_url: song.preview_url,
      duration_ms: song.duration_ms,
      explicit: song.explicit,
      spotify_id: song.id,
      album_id: album_id
    }
    save_song(song_data)
  end
end

def save_song(data)
  Song.find_or_create_by(spotify_id: data[:spotify_id])
      .update!(data)
  p "Song: #{data[:name]} updated"
end