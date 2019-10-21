class SpotifyClientService

  def authenticate
    headers = {Authorization: "Basic #{Base64.strict_encode64("#{Figaro.env.spotify_client_id}:#{Figaro.env.spotify_client_secret}")}"}
		payload = {grant_type: 'client_credentials'}
    response = RestClient.post("https://accounts.spotify.com/api/token",payload,headers)
    JSON.parse(response.body)['access_token']
  end

  def search_artist(nane)
    #Search on spotify

    #Create locally
    Artist.create(name: name)
  end
end
