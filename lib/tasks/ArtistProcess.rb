require_relative 'BaseObject'
require_relative 'ArtistCompose'
class ArtistProcess < BaseObject
  def processArtistName(value)
    @art = Artist.new
    artists = RSpotify::Artist.search(value.to_s)
    artist = artists.first
    artists.each do |artistObject|
        artistObject.images.each do |key|
          image = OpenStruct.new(key)
          @art.image = image.url.to_s
        end
        @art.popularity = artistObject.popularity
        @art.genres = artistObject.genres
        artistsbase = RSpotify::Base.search(artistObject.name.to_s, 'artist')
        artistsbase.each do |objetob|
          @art.spotitify_id = objetob.id.to_s
          @art.spotify_url = objetob.uri.to_s
        end
        @art.name = artistObject.name.to_s
        @art.save
        artistCompose = ArtistCompose.new(artistObject, @art.spotitify_id, artistObject.albums, artistObject.genres)
        return artistCompose
    end         
    rescue => e 
      puts e
      return showError
  end
end 