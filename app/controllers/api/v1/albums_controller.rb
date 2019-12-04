class Api::V1::AlbumsController < ApplicationController
  #mostrar todos los albumes
  def index
    @albums  = Album.all
    render json: {data:@albums}   
  end
  #mostrar todos las canciones referentes de un album
  def songs
  	@songs = Album.find(params[:id])
    songs  = RSpotify::Track.search(@songs.name)
  	@songs = songs.map do |s_songs|
    	Song.new_from_spotify_song(s_songs)
    end
    render json: {data:@songs}
  end

end
