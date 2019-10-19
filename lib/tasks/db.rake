# Rakefile
# frozen_string_literal: true

require 'rspotify'

namespace :db do
  namespace :seed do
    desc "Load artists from Spotify API"

    task :load_artists => :environment do
      artist_names = YAML.load_file("#{Rails.root.to_s}/lib/tasks/artists.yml")
      RSpotify.authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_KEY'])
      puts artist_names
      # for i in (0..artist_names.size - 1) do
      for i in (0..1) do
        artist = RSpotify::Artist.search(artist_names["Artist_#{i}"]).first
        artist.albums
        artist.albums.first.tracks
      end
    end
  end
end