class SongsController < ApplicationController
 
  def index
    if params[:album_id]
      @songs = Album.find(params[:album_id]).songs
    else
      @songs = Song.all
    end

    render json: @songs
  end

end
