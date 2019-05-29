class Api::V1::ArtistsController < ActionController::Base

  def index
    response = Artist::GetAll.call()
    render json: response[:response], status: response[:status]
  end


  def get_albums

    artist_id = params[:id]
    response = Artist::GetAlbums.call(artist_id)
    render json: response[:response], status: response[:status]
  end

end