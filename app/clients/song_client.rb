class SongClient < Spotify
    def fetch
      Song.delete_all
      albums = Album.all
      albums.each do |album|
        songs = search(album.spotify_id)
        songs.each do |song|
          save(song, album)
        end
      end 
    end
    
    private
    
    def save(song, album)
      Song.create(
      name: song['name'],
      spotify_url: song['external_urls']['spotify'],
      preview_url: song['preview_url'],
      duration_ms: song['duration_ms'],
      explicit: song['explicit'],
      spotify_id: song['id'],
      album: album
      )
    end
    
    def search(id)
      JSON.parse(super(id))['items']
    end
    
    def query_url(id)
      "https://api.spotify.com/v1/albums/#{id}/tracks"
    end
  end
  