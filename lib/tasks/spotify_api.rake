require 'rspotify'
require 'yaml'


namespace :spotify_api do
  desc "TODO"
  task get_data: :environment do
    puts "************** Beginning of task **************"
    RSpotify.authenticate('04bbe1c429004d059db4d779f7b07ef1', 'f4ba6691b34648b7813dd454cf783509')
    file = YAML::load(File.open('config/artists.yml'))
    file["artists"].each do |artist|
    # fetching artist data from the yaml
      people = RSpotify::Artist.search(artist.to_s)
      thing = people.first
      puts 'Artist', thing.name
      artist_data = {name: thing.name,
          image: thing.images.first["url"],
          genres: thing.genres.to_s,
          popularity: thing.popularity,
          spotify_url: thing.external_urls["spotify"],
          spotify_id: thing.id}

      artist_created = Artist.create(artist_data)
      puts artist_created
      sleep 2
      # fetching artist_albums data using the first query
      albums = thing.albums
      albums.each do |album|
        puts 'Album', album.name
        album_data = {name: album.name,
                      image: album.images.first["url"],
                      spotify_url: album.external_urls["spotify"],
                      total_tracks: album.tracks.size,
                      spotify_id: album.id,
                      artist_id: artist_created.id}

        album_created = Album.create(album_data)
        puts album_created
        sleep 2
        # finally getting album_tracks from the queries done before
        album.tracks.each do |track|
          puts 'Song', track.name
          track_data = {name: track.name,
                        spotify_url: track.external_urls["spotify"],
                        preview_url: track.preview_url,
                        duration_ms: track.duration_ms,
                        explicit: track.explicit,
                        spotify_id: track.id,
                        album_id: album_created.id}

          song_created = Song.create(track_data)
          puts song_created
        end
      end
      sleep 2
    end
  end

end
