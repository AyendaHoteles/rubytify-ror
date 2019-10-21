class SpotifyClientService
  @@auth_url = "https://accounts.spotify.com/api/token"
  @@base_url = "https://api.spotify.com/v1"

  def initialize()
    authenticate unless Rails.cache.read(:access_token)
  end

  def find_artist(name)
    #Search on spotify
    headers = {Authorization: "Bearer #{Rails.cache.read(:access_token)}"}
    url = "#{@@base_url}/search?q=#{URI.encode(name)}&type=artist"
    response = RestClient.get(url, headers)
    response_parsed = JSON.parse(response.body)

    if (response_parsed['artists']['total'] > 0)
      #Create locally
      artist_spotify_hash = response_parsed['artists']['items'][0]
      artist = Artist.find_or_create_by(spotify_url: artist_spotify_hash['external_urls']['spotify'])
      Artist.update(artist.id, name: artist_spotify_hash['name'],image: artist_spotify_hash['images'][0]['url'],genres: artist_spotify_hash['genres'], popularity: artist_spotify_hash['popularity'],spotify_url: artist_spotify_hash['external_urls']['spotify'])
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
end
