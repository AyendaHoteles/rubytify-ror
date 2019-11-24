class SpotifyImporter

  attr_reader :artist_list

    def initialize()
      @artist_list = artist_list
    end

    def call
    artist_list.each do |artist|
      spotify_artist = RSpotify::Artist.search(artist).first
      if spotify_artist
        artist = create_artist(spotify_artist)

        spotify_artist.albums.each do |spotify_album|
          album = create_album(artist,spotify_album)

          spotify_album.tracks.each do |spotify_track|
            create_song(album, spotify_track)
          end
        end
      else
        puts "Artist #{artist} not found"
      end
    end

    def create_artist(spotify_artist)
      artist = Artist.create(
        name: spotify_artist.name,
        image: spotify_artist.images.first["url"]
        genres: spotify_artist.genres,
        popularity: spotify_artist.popularity,
        spotify_url: spotify_artist.href,
        spotify_id: spotify_artist.id
      )
    end

    def create_album(artist, spotify_album)
      artist.albums.create(
        name: spotify_album.name,
        image: spotify_album.images,first["url"],
        spotify_url: spotify_album.href,
        total_tracks: spotify_album.total_tracks,
        spotify_id: spotify_album.id
      )
    end

    def create_song(album, spotify_track)
      album.songs.create(
        name:spotify_track.name,
        spotify_url: spotify_track.href,
        preview_url: spotify_track.preview_url,
        duration_ms: spotify_track.explicit,
        spotify_id: spotify_ttack.id
      )
    end  
end