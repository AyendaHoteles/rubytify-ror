class Api::V1::SongsController < ApplicationController
  before_action :get_album, only: [:index]

  def index
    render json: @album.songs
  end

  private

  def get_album
    @album = Album.find(params[:album_id])
  end
end
