# frozen_string_literal: true

require 'yaml'
namespace :artists do
  desc 'load artists from yml file'
  task load_artists: :environment do
    artists_names = YAML.load_file(Rails.root.join('lib', 'artists.yml'))
    artists_names['artists'].each_with_index do |artist, _index|
      artist_guard = Artist.find_by(name: artist)
      # if artist already exists it should not fetch
      next if artist_guard

      puts "Fetching #{artist}"
      spotify_artist = RSpotify::Artist.search(artist.to_s)
      # if artist does not exist in spotify it should not fech
      next unless spotify_artist && spotify_artist != []

      # create artist in DB
      a = Artist.create!(name: artist, image: spotify_artist.first.images.first['url'], popularity: spotify_artist.first.popularity,
                         spotify_url: spotify_artist.first.href, spotify_id: spotify_artist.first.id)
      # create genres in DB
      spotify_artist.first.genres.each do |genre|
        g = Genre.find_by(name: genre)
        g ||= Genre.create!(name: genre)
        a.genres << g
      end
      # create albums in DB
      spotify_artist.first.albums.each do |album|
        b = a.albums.create!(name: album.name, image: album.images.first['url'], spotify_url: album.href,
                             spotify_id: album.id, total_tracks: album.total_tracks)
        album.tracks.each do |track|
          # create songs in DB
          b.songs.create!(name: track.name, spotify_url: track.href,
                          preview_url: track.preview_url,
                          duration_ms: track.duration_ms, explicit: track.explicit,
                          spotify_id: track.id)
        end
      end
    rescue StandardError => e
      puts "#{artist.name}, #{e}"
    end
  end
end
