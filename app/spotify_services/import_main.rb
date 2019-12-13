class ImportMain
  attr_reader :spotify_request, :data

  def initialize(spotify_request, data)
    @spotify_request = spotify_request
    @data = data
  end

  def spotify_import
    @spotify_request.request_api(@data.get_artists)
  end
end
