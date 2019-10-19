require 'rspotify'

module Importer
  def self.start
    RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])

    yml_path = "#{Rails.root}/config/artists.yml"
    yml = File.exists?(yml_path) ? YAML.load_file(yml_path) : nil

    unless yml.nil?
      yml['artists'].each do |name|
        artist = RSpotify::Artist.search(name).first

        if artist
          app_artist = Artist.find_or_create_by(
            name: artist.name,
            image: artist.images.first['url'],
            popularity: artist.popularity,
            spotify_id: artist.id,
            spotify_url: artist.uri
          )

          artist.genres.each do |g|
            app_artist.genres.find_or_create_by(name: g)
          end
        end
      end
    end
  end
end
