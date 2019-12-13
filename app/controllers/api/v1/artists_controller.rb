class Api::V1::ArtistsController < ApplicationController
  def index
    artists = Artist.order(popularity: :desc)
    render json: artists, adapter: :json, root: 'data', status: :ok
  end

  def albums
    artist = Artist.find_by(id: params[:artist_id])
    if artist
      render json: artist.albums, adapter: :json, root: 'data', status: :ok
    else
      render json: {}, status: :not_found
    end
  end
end
