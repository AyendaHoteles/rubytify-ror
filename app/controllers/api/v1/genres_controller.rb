class Api::V1::GenresController < ApplicationController
  
  #random de las canciones
  def random_song
   @artists = Artist.all
   @generosarray =[]
   @generos = @artists.map do |s_songs|   
     @genero = s_songs.genres
     unless @genero[params[:genre_name]].nil? 
       @genero = @genero[params[:genre_name]]
       @generosarray << s_songs
     end
   end
   #verificacion si el array llega vacio
   if @generosarray.empty?
      render json: {data:["notice"":""sin registros"]}
   else
   	  #busqueda en spotify de las canciones, con su respectivo random(sample)
      songs  = RSpotify::Track.search(@generosarray.sample.name)
      @songs = songs.map do |s_songs|
    	Song.new_from_spotify_song(s_songs)
      end
      render json: {data:@songs}
  	end
  end

end