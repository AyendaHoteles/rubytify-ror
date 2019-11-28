class AlbumsController < ApplicationController

  def index
    if params[:artist_id]
      @albums = Artist.find(params[:artist_id]).albums
    else
      @albums = Album.all
    end
    
    render json: @albums
  end

end
