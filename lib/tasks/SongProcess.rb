require_relative 'BaseObject'
class SongProcess < BaseObject
  def processSongs(genres, idAlbum, albumEach)
      genreStr = ""
      genres.each do |genre|
        genreStr = genreStr + genre + ";"
      end  
      tracks = albumEach.tracks
      tracks.each do |track|
        @song = Track.new
        @song.spotify_id_album = idAlbum.to_s
        @song.duration_ms = track.duration_ms
        @song.name = track.name.to_s
        @song.preview_url = track.preview_url.to_s
        trackBase  = RSpotify::Base.search(idAlbum.to_s, 'track')
        trackBase.each do |baseObject|
          @song.spotify_id = baseObject.id.to_s
          @song.spotify_url = baseObject.uri.to_s
        end
        @song.genres = genreStr
      end  
      @song.save 
      rescue => e 
      puts e
      return showError
  end 
end 