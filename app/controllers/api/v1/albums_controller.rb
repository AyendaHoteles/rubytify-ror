class Api::V1::AlbumsController < ApplicationController
  def index
    id = params[:artist_id]
    artist = Artist.includes(:albums).find_by_id(id)
    return render json: {data: []}, status: :not_found unless artist
    render json: {data: artist.albums}, status: :ok
  end
end
