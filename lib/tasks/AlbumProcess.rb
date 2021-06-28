require_relative 'BaseObject'
class AlbumProcess < BaseObject
  def processAlbums(artistObject,idArtist,albums, genres)
      @album = Album.new
      albumI = albums
      albums.each do |albumEach|
          @album.name = albumEach.name.to_s
          puts @album.name
          albumBase  = RSpotify::Base.search(albumEach.name.to_s, 'album')
          albumBase.each do |baseObject|
            @album.spotify_id = baseObject.id.to_s
            @album.spotify_url = baseObject.uri.to_s
          end
          albumEach.images.each do |key|
            image = OpenStruct.new(key)
            @album.image = image.url.to_s
          end  
          @album.spotify_id_artist = idArtist.to_s
          @album.name = albumEach.name.to_s
          @album.total_tracks = albumEach.total_tracks
          @album.save
          songProcessObject = SongProcess.new
          songProcessObject.processSongs(genres, @album.spotify_id, albumEach)
          @album
      end    
      rescue => e 
        puts e
        return showError
  end 
end 