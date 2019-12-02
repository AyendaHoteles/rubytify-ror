class Api::V1::SongsController < ApplicationController
  
  def index
    render json: {
      data: serializable_data(
        Song.get_songs_by_album(params[:id])
      )
    }
  end

  def random_song
    render json: {
      data: serializable_data(
        Song.get_random_song(params[:genre_name]).sample
      )
    }
  end

end
