require 'rspotify'

module Importer
  def self.start
    RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])

    yml_path = "#{Rails.root}/config/artists.yml"
    yml = File.exists?(yml) ? YAML.load_file(yml_path) : nil

    unless yml.nil?
      yml['artists'].for_each do |name|
        artist = RSpotify::Artist.search(name).first
        Artist.find_or_create(
          name: artist.name,
          # genres: artist.genres,
          popularity: artist.popularity,
          spotify_id: artist.id,
          spotify_url: artist.uri
        )
      end
    end
  end
end
