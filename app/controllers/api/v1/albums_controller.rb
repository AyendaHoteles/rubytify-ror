class Api::V1::AlbumsController < ApplicationController
  before_action :load_artist

  def index
    render json: @artist.albums
  end

  private

  def load_artist
    @artist = Artist.find(params[:artist_id])
  end
end
