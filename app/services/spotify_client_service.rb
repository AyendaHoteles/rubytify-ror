class SpotifyClientService
  @@auth_url = "https://accounts.spotify.com/api/token"
  @@base_url = "https://api.spotify.com/v1"

  def initialize()
    authenticate unless Rails.cache.read(:access_token)
  end

  def find_artist(name)
    authenticate unless Rails.cache.read(:access_token)
    #Search on spotify
    headers = {Authorization: "Bearer #{Rails.cache.read(:access_token)}"}
    url = "#{@@base_url}/search?q=#{URI.encode(name)}&type=artist"
    response = RestClient.get(url, headers)
    response_parsed = JSON.parse(response.body)
    if (response_parsed['artists']['total'] > 0)
      #Create locally
      artist_spotify_hash = response_parsed['artists']['items'][0]
      artist = Artist.find_or_create_by(spotify_id: artist_spotify_hash['id'])
      Artist.update(artist.id, name: artist_spotify_hash['name'],image: artist_spotify_hash['images'][0]['url'],genres: artist_spotify_hash['genres'], popularity: artist_spotify_hash['popularity'],spotify_url: artist_spotify_hash['external_urls']['spotify'])
      obtain_albums(artist)
    end
  end

  private

  def authenticate
    headers = {Authorization: "Basic #{Base64.strict_encode64("#{Figaro.env.spotify_client_id}:#{Figaro.env.spotify_client_secret}")}"}
		payload = {grant_type: 'client_credentials'}
    response = RestClient.post(@@auth_url,payload,headers)
    access_token = JSON.parse(response.body)['access_token']
    expires_in_seconds = JSON.parse(response.body)['expires_in']
    Rails.cache.write(:access_token, access_token, expires_in: expires_in_seconds.seconds)
  end

  def obtain_albums(artist)
    authenticate unless Rails.cache.read(:access_token)
    #TODO Search all albums
    headers = {Authorization: "Bearer #{Rails.cache.read(:access_token)}"}
    url = "#{@@base_url}/artists/#{artist.spotify_id}/albums?offset=0&limit=50"
    response = RestClient.get(url, headers)
    response_parsed = JSON.parse(response.body)
    albums_spotify_hash = response_parsed['items']
    albums_spotify_hash.each do |album_spotify_hash|
      begin
        album = Album.find_or_create_by(spotify_id: album_spotify_hash['id'] )
        album.artist = artist
        album.save!
        image_url = !album_spotify_hash['images'].empty? ? album_spotify_hash['images'].first['url'] : ''
        Album.update(album.id,name: album_spotify_hash['name'], image: image_url, spotify_url: album_spotify_hash['href'], artist_id: artist.id, total_tracks: album_spotify_hash['total_tracks'])
        obtain_songs(artist, album)
      rescue  => ex
        puts ex.message
      end
    end
  end

  def obtain_songs(artist, album)
    authenticate unless Rails.cache.read(:access_token)
    headers = {Authorization: "Bearer #{Rails.cache.read(:access_token)}"}
    url = "https://api.spotify.com/v1/albums/#{album.spotify_id}/tracks?offset=0&limit=50"
    response = RestClient.get(url, headers)
    response_parsed = JSON.parse(response.body)
    tracks_spotify_hash = response_parsed['items']
    tracks_spotify_hash.each do |track_spotify_hash|
      begin
        song = Song.find_or_create_by(spotify_id: track_spotify_hash['id'] )
        song.album_id = album.id
        song.save!
        Song.update(song.id,name: track_spotify_hash['name'], spotify_url: track_spotify_hash['href'], duration_ms: track_spotify_hash['duration_ms'], explicit: track_spotify_hash['explicit'])
      rescue  => ex
        puts ex.message
      end
    end
  end

end
