class Api::V1::AlbumsController < ApplicationController
  before_action :get_artist, only: [:index]

  def index
    render json: @artist.albums
  end

  private

  def get_artist
    @artist = Artist.find(params[:artist_id])
  end
end
