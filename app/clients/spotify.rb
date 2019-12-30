
class Spotify
  attr_reader :client_id, :client_secret 
  protected :client_id, :client_secret

  def initialize
    # TODO: move to ENV vars 
    @client_id = ENV['SPOTY_CLIENT_ID']
    @client_secret = ENV['SPOTY_CLIENT_SECRET']
  end

  def grant
    Base64.strict_encode64("#{client_id}:#{client_secret}")
  end

  def get_token
    resp = RestClient.post('https://accounts.spotify.com/api/token',
                          {'grant_type' => 'client_credentials'},
                          {"Authorization" => "Basic #{grant}"})
    JSON.parse(resp)["access_token"]
  end

  def search(param)
    RestClient.get(query_url(param), headers=query_headers)
  end

  def query_headers
    { 
      "Accept" => "application/json",
      "Content-Type" => "application/json", 
      "Authorization" => "Bearer #{get_token}" 
    }
  end
end
