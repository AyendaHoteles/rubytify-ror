class SpotifySyncWorker
  include Sidekiq::Worker

  def perform(*args)
    begin
      Rails.logger.info('---start sync---')

      artist_names = YAML.load_file(Rails.root + 'config/spotify/artists.yml')['artists']

      artist_names.each do |artist_name|
        next if Artist.where("name like (?)", artist_name.to_s).any?

        RSpotify::Artist.search(artist_name.to_s).each do |spotify_artist|
          Rails.logger.info("---artist: #{spotify_artist.name}---")

          artist = Artist.where(spotify_id: spotify_artist.id).first_or_create do |obj|
            obj.name = spotify_artist.name
            obj.image = spotify_artist.images.first.try(:[], 'url')
            obj.genres = spotify_artist.genres
            obj.popularity = spotify_artist.popularity
            obj.spotify_url = spotify_artist.uri
          end

          next unless artist.valid?

          Rails.logger.info("---saved artist: #{artist.id}---")

          spotify_albums = spotify_artist.albums

          Rails.logger.info('---sync_albums---')

          spotify_albums.each do |spotify_album|
            Rails.logger.info("artist's albums #{artist.name} : #{spotify_album.name}")

            album = artist.albums.where(spotify_id: spotify_album.id).first_or_create do |obj|
              obj.name = spotify_album.name
              obj.image = spotify_album.images.first.try(:[], 'url')
              obj.total_tracks = spotify_album.total_tracks
              obj.spotify_url = spotify_album.uri
            end

            next unless album.valid?

            Rails.logger.info("---saved album #{album.id}---")

            spotify_songs = spotify_album.tracks

            Rails.logger.info('---sync_tracks---')

            spotify_songs.each do |spotify_song|
              Rails.logger.info("Artist: #{artist.name} Album: #{album.name} Song: #{spotify_song.name}")

              song = album.songs.where(spotify_id: spotify_song.id).first_or_create do |obj|
                obj.name = spotify_song.name
                obj.duration_ms = spotify_song.duration_ms
                obj.explicit = spotify_song.explicit
                obj.preview_url = spotify_song.preview_url
                obj.spotify_url = spotify_song.uri
              end

              next unless song.valid?

              Rails.logger.info("---saved song #{song.id}---")
            end
          end
        end
      end
    rescue RestClient::TooManyRequests => error
      Rails.logger.info(error)
      sleep 5
      retry
    end
  end
end
