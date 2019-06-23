class Api::V1::SongsController < ApplicationController
  def index
    album_id = params[:album_id]
    album = Album.preload(:songs).find_by_id(album_id)
    return render json: {data: []}, status: :not_found unless album
    render json: {data: album.songs}, status: :ok
  end
  def random
    songs = Song.joins(album: :artist).where("artists.genres like ?", "%#{params[:genre_name]}%").uniq
    render json: {data: [songs.sample]}, status: :ok
  end
end
