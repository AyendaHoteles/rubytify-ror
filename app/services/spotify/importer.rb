# frozen_string_literal: true

require 'rspotify'

module Spotify
  # Imports articles with images, albums and songs.
  class Importer
    LIMIT = 50

    def self.call(artists_names)
      ActiveRecord::Base.transaction do
        search_spotify_artists(artists_names).each do |spotify_artist|
          artist = create_artist(spotify_artist)
          spotify_artist.albums(limit: LIMIT).each do |spotify_album|
            album = create_album(artist, spotify_album)
            spotify_album.tracks(limit: LIMIT).each do |spotify_track|
              create_song(album, spotify_track)
            end
          end
        end
      end
    end

    def self.search_spotify_artists(artists_names)
      artists_names.map do |artist_name|
        RSpotify::Artist.search(artist_name).first
      end.reject(&:blank?)
    end

    def self.create_artist(spotify_artist)
      Artist.create!(
        name: spotify_artist.name,
        genres: spotify_artist.genres,
        popularity: spotify_artist.popularity,
        spotify_url: spotify_artist.href,
        spotify_identifier: spotify_artist.id,
        image: build_image(spotify_artist.images.first)
      )
    end

    def self.create_album(artist, spotify_album)
      artist.albums.create!(
        name: spotify_album.name,
        total_tracks: spotify_album.total_tracks,
        spotify_url: spotify_album.href,
        spotify_identifier: spotify_album.id,
        image: build_image(spotify_album.images.first)
      )
    end

    def self.create_song(album, spotify_track)
      album.songs.create!(
        name: spotify_track.name,
        explicit: spotify_track.explicit,
        duration_ms: spotify_track.duration_ms,
        preview_url: spotify_track.preview_url,
        spotify_url: spotify_track.href,
        spotify_identifier: spotify_track.id
      )
    end

    def self.build_image(spotify_image)
      return unless spotify_image
      Image.new(
        url: spotify_image[:url],
        width: spotify_image[:width],
        height: spotify_image[:height]
      )
    end
  end
end
