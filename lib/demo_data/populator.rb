module DemoData
  class Populator
    attr_reader :artists_names
    RSpotify.authenticate(ENV['SPOTIFY_KEY'],
                          ENV['SPOTIFY_SECRET'])

    def initialize(artists_names)
      @artists_names = artists_names
    end

    def process
      artists_names.each do |artist_name|
        # we want to keep these variables in this scope.
        spotify_artist, artist, album, albums, tracks = nil
        handle_429 do
          spotify_artist = RSpotify::Artist.search(artist_name.to_s, limit: 1).first
        end
        next unless spotify_artist

        Artist.transaction do
          handle_429 { artist = insert_artist(spotify_artist) }
          handle_429 { albums = spotify_artist.albums }
          albums.each do |spotify_album|
            handle_429 { album = insert_album(spotify_album, artist) }
            handle_429 { tracks = spotify_album.tracks }
            tracks.each do |spotify_track|
              handle_429 { insert_song(spotify_track, album) }
            end
          end
        end
      end
    end

    private def handle_429 # Also know as too_many_requests.
      yield
    rescue RestClient::TooManyRequests => e
      sleep e.response.headers[:retry_after].to_i
      handle_429 { yield }
    end

    private def insert_artist(artist)
      record = Artist.where(name: artist.name,
                            image: artist.images&.fetch(0, {})['url'],
                            popularity: artist.popularity,
                            spotify_url: artist.external_urls['spotify'],
                            spotify_id: artist.id).first_or_create!
      record.genres = artist.genres
      record.save!
      record
    end

    private def insert_album(album, artist)
      Album.where(name: album.name,
                  image: album.images&.fetch(0, {})['url'],
                  spotify_url: album.external_urls['spotify'],
                  spotify_id: album.id,
                  total_tracks: album.total_tracks,
                  artist: artist).first_or_create!
    end

    private def insert_song(song, album)
      Song.where(name: song.name,
                 spotify_url: song.external_urls['spotify'],
                 preview_url: song.preview_url,
                 duration_ms: song.duration_ms,
                 explicit: song.explicit,
                 spotify_id: song.id,
                 album: album).first_or_create!
    end
  end
end
