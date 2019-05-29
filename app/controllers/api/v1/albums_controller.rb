class Api::V1::AlbumsController < ActionController::Base

  def get_songs

    album_id = params[:id]
    response = Album::GetSongs.call(album_id)
    render json: response[:response], status: response[:status]
  end

end