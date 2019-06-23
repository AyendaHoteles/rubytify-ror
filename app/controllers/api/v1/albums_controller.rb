class Api::V1::AlbumsController < ApplicationController
  def index
    artist_id = params[:artist_id]
    artist = Artist.preload(:albums).find_by_id(artist_id)
    return render json: {data: []}, status: :not_found unless artist
    render json: {data: artist.albums}, status: :ok
  end
end
