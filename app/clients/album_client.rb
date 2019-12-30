class AlbumClient < Spotify
  def fetch
    Album.delete_all
    artists = Artist.all
    artists.each do |artist|
      albums = search(artist.spotify_id)
      albums.each do |album|
        save(album, artist)
      end
    end 
  end
  
  private
  
  def save(album, artist)
    Album.create(
    name: album['name'],
    image: album['images'],
    spotify_url: album['external_urls']['spotify'],
    total_tracks: album['total_tracks'],
    spotify_id: album['id'],
    artist: artist
    )
  end
  
  def search(id)
    JSON.parse(super(id))['items']
  end
  
  def query_url(id)
    "https://api.spotify.com/v1/artists/#{id}/albums"
  end
  
  def artist_ids
    Artist.all.map{ |x, y| x.spotify_id }
  end
end
