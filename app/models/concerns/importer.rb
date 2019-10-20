require 'rspotify'

module Importer
  def self.start(yml_path = "#{Rails.root}/config/artists.yml")
    RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])

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
            spotify_url: artist.href
          )

          artist.genres.each do |g|
            app_artist.genres.find_or_create_by(name: g)
          end

          artist.albums.each do |album|
            app_album = app_artist.albums.find_or_create_by(
              name: album.name,
              image: album.images.first['url'],
              spotify_id: album.id,
              spotify_url: album.href,
              total_tracks: album.tracks.count
            )

            if app_album.persisted?
              album.tracks.each do |track|
                app_album.songs.find_or_create_by(
                  name: track.name,
                  preview_url: track.preview_url,
                  duration_ms: track.duration_ms,
                  explicit: track.explicit,
                  spotify_url: track.href,
                  spotify_id: track.id
                )
              end
            end
          end
        end
      end
    end
  end
end
