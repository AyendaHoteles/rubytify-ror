class Api::V1::GenresController < ApplicationController
  before_action :find_model, only: [:show]

  def show
    @random_song = @artist_with_genre.first.albums.first.songs.first #implementar random
    render json: @random_song
  end

  private
  def find_model
    @artist_with_genre = Artist.artist_genre(params[:genres]) 
  end
  
end


