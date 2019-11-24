require 'rspotify'
require 'spotify_importer'

namespace :import do
  desc "Feed DB with artist's info from Spotify"
  task spotify: :environment do
    artists_list = YAML.load_file(Rails.root.join("lib", "seeds", "artists.yml"))
    
    SpotifyImporter.new(artist_list["artists"]).call
  end
end
