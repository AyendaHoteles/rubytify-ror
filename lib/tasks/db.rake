# frozen_string_literal: true

require 'rspotify'

namespace :db do
  desc "It records the artist's info, albums and songs"
  task spotify: :environment do
    Rake::Task['db:artists'].invoke
    Rake::Task['db:albums'].invoke
    Rake::Task['db:songs'].invoke
  end

  desc "It records the artist's info"
  task artists: :environment do
    puts "Importing artists from Spotify"
    artists = YAML.safe_load(File.read('artists.yml'))

    artists['artists'].each do |artist|
      @current_artist = RSpotify::Artist.search(artist.to_s).first

      Artist.where(name: @current_artist.name).first_or_create(
        image: @current_artist.images.first['url'],
        genres: @current_artist.genres,
        popularity: @current_artist.popularity,
        spotify_url: @current_artist.external_urls['spotify'],
        spotify_id: @current_artist.id
      )
    end
  end

  desc "It records the albums"
  task albums: :environment do
    puts "Importing artists from Albums"
    artists = Artist.all

    artists.each do |artist|
      albums = RSpotify::Artist.search(artist.name).first.albums

      albums.each do |album|
        my_album = Album.where(spotify_id: album.id).first_or_create(
          name: album.name,
          spotify_url: album.external_urls['spotify'],
          total_tracks: album.total_tracks,
          artist_id: artist.id
        )

        my_album.update(image: my_album.image?(album))
      end
    end
  end

  desc "It records the songs"
  task songs: :environment do
    puts "Importing songs from Spotify"
    albums = Album.all

    albums.each do |album|

      current_album = RSpotify::Album.find(album.spotify_id)
      songs = current_album.tracks

      songs.each do |song|
        Song.where(spotify_id: song.id).first_or_create(
          name: song.name,
          spotify_url: song.external_urls['spotify'],
          preview_url: song.preview_url,
          duration_ms: song.duration_ms,
          explicit: song.explicit,
          album_id: album.id
        )
      end
    end
  end
end
