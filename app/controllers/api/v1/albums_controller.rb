class Api::V1::AlbumsController < ApplicationController

  def index
    artist = Artist.find(params[:id])
    render  json: { data: artist.albums }, status: 200
  end
end
