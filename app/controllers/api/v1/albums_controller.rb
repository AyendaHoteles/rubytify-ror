class Api::V1::AlbumsController < ApplicationController
  def index
    artist = Artist.find_by(spotify_id: params[:artist_id])

    albums = artist.albums

    albums_data = albums.map {|album| album.create_body }

    render json: {data: albums_data}.to_json , status: 200
  end
end
