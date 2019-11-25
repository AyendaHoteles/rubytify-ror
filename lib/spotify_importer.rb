class SpotifyImporter
  attr_reader :artist_list
  def initialize(artist_list)
    @artist_list = artist_list
  end
  def call
    artist_list.each do |artist|
      spotify_artist = RSpotify::Artist.search(artist.to_s).first
      if spotify_artist
        artist = create_artist(spotify_artist)
        spotify_artist.albums.each do |spotify_album|
          album = create_album(artist, spotify_album)
          spotify_album.tracks.each do |spotify_track|
            create_song(album, spotify_track)
          end
        end
      else
        puts "Artist #{artist} not found"
      end
    end
  end
  def create_artist(spotify_artist)
    Artist.find_or_create_by(spotify_id: spotify_artist.id) do |artist|
      puts "Creating #{artist.name} in the DB"
      artist.name = spotify_artist.name
      artist.image = spotify_artist.images.first["url"]
      artist.genres = spotify_artist.genres
      artist.popularity = spotify_artist.popularity
      artist.spotify_url = spotify_artist.href
      artist.spotify_id = spotify_artist.id
      puts "the artist #{artist.name} has been created"
    end
  end
  def create_album(artist, spotify_album)
    artist.albums.find_or_create_by(spotify_id: spotify_album.id) do |album|
      puts "Creating #{album.name}"
      album.name = spotify_album.name
      album.image = spotify_album.images.first["url"]
      album.spotify_url = spotify_album.href
      album.total_tracks = spotify_album.total_tracks
      album.spotify_id = spotify_album.id
      puts "the album #{album.name} has been created"
    end
  end
  def create_song(album, spotify_track)
    sleep 1 #prevent reaching  spotify api limit. 

    album.songs.find_or_create_by(spotify_id: spotify_track.id) do |song|
      puts "Creating #{song.name}"
      song.name = spotify_track.name
      song.spotify_url = spotify_track.href
      song.preview_url = spotify_track.preview_url
      song.duration_ms = spotify_track.duration_ms
      song.explicit = spotify_track.explicit
      song.spotify_id = spotify_track.id
      puts "the song #{song.name} has been created"
    end
  end
end