class Api::V1::SongsController < ApplicationController
  def index
    id = params[:album_id]
    album = Album.includes(:songs).find_by_id(id)
    return render json: {data: []}, status: :not_found unless album
    render json: {data: album.songs}, status: :ok
  end

  def random
    song = Song.joins(album: :artist).where("artists.genres like ? ", "%#{params[:genre_name]}%").sample
    render json: {data: [song]}, status: :ok
  end
end
