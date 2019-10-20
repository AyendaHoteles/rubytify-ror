class Api::V1::SongsController < ApplicationController
  before_action :load_album

  def index
    render json: @album.songs
  end

  private

  def load_album
    @album = Album.find(params[:album_id])
  end
end
