class Api::V1::AlbumsController < ApplicationController

  def index
    render json: {
      data: serializable_data(
        Album.get_albums_by_artist(params[:artist_id])
      )
    }
  end

end
