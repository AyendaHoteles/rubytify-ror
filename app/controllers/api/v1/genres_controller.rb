class Api::V1::GenresController < ApplicationController

   #GET /api/v1/genres/:genre_name/random_song
   def random_song
   
      search = "CAST(genres AS varchar) LIKE '%" + params[:genre_name] + "%'"
      @artists = Artist.all.where(search)
      
      if @artists.length > 0
         len_artists = @artists.length
         pos_artist = rand(len_artists)
         @albums = Album.where("artist_id = ?", @artists[pos_artist].id)
         
         len_albums = @albums.length
         pos_album = rand(len_albums)
         @songs = Song.where("album_id = ?", @albums[pos_album].id)
         
         len_song = @songs.length
         pos_song = rand(len_song)
         
         render json: @songs[pos_song], root: 'data', each_serializer: SongSerializer, adapter: :json
      else
         render json: { data: {} }
      end
      
   end
end
