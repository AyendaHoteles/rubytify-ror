require 'rspotify'
require 'yaml'

namespace :db do
  namespace :seed do
    desc 'Fetch data from /db/seeds/artist.yml throught Spotify API'
    task import_data: :environment do

      artists = YAML.load(File.read('db/seeds/artist_list.yml'))

      artists['artists'].each do |artist|
        the_artists = RSpotify::Artist.search(artist.to_s)
        begin
          an_artist = the_artists.first

          if an_artist
            new_artist = Artist.create({
              name: an_artist.name,
              image: an_artist.images.first['url'],
              genres: an_artist.genres,
              popularity: an_artist.popularity,
              spotify_url: an_artist.external_urls['spotify'],
              spotify_id: an_artist.id
            })
            new_artist.save!
          end

          albums = an_artist.albums
          albums.each do |album|
            new_album = Album.create({
              name: album.name,
              image: album.images[0],
              total_tracks: album.total_tracks,
              spotify_url: album.external_urls['spotify'],
              spotify_id: album.id,
              artist_id: new_artist.id
            })
            new_album.save!

            if new_album
              songs = album.tracks
              songs.each do |song|
                new_song = Song.create({
                  name: song.name,
                  duration_ms: song.duration_ms,
                  explicit: song.explicit,
                  preview_url: song.preview_url,
                  spotify_url: song.external_urls['spotify'],
                  spotify_id: song.id,
                  album_id: new_album.id
                })
                new_song.save!
              end
            end
          end
        rescue RestClient::TooManyRequests => e
          puts 'Cooling down petitions'
          sleep(0.1)
        end
      end
    end
  end
end
