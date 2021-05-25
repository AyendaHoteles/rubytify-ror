require 'yaml'
require 'rspotify'

namespace :fetch do
  desc "Task for fetching info about artist on spotify api"
  task spotify: :environment do
    Rake::Task['db:reset'].invoke

    if File.file?('config/artists.yml')

      data = YAML.load_file('config/artists.yml')

      data['artists'].each do |artist|
        spotify_artist = RSpotify::Artist.search(artist.to_s).first

        if spotify_artist
          p '=> Creating artists from .yml file'
          artist = Artist.create!(name: spotify_artist.name,
                                  image: spotify_artist.images.sample['url'],
                                  genres: spotify_artist.genres.join(","),
                                  popularity: spotify_artist.popularity,
                                  spotify_url: spotify_artist.external_urls['spotify'],
                                  spotify_id: spotify_artist.id
          )


          # p "=> Creating albums for artists"
          spotify_artist.albums&.each do |album|

            new_album = Album.create!(name: album.name,
                                      image: !album.images.nil? && !album.images.sample.nil? ? album.images.sample['url'] : '',
                                      spotify_url: album.external_urls['spotify'],
                                      total_tracks: album.total_tracks,
                                      spotify_id: album.id,
                                      artist_id: artist.id)
            new_album.save!

            # p "=> Creating songs for album"
            album.tracks.each do |track|
              Song.create!(name: track.name,
                           spotify_url: track.external_urls['spotify'],
                           spotify_id: track.id,
                           preview_url: !track.preview_url.nil? ? track.preview_url : '',
                           duration: track.duration_ms,
                           explicit: track.explicit,
                           album_id: new_album.id)
            end

          end

        end
      end

    end
  end
end