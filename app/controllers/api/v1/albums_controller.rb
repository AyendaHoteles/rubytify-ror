class Api::V1::AlbumsController < ApplicationController
  before_action :load_album, only: [:songs]

  def songs
    render json: build_response(@album.songs, SongSerializer)
  end

  private

  def load_album
    @album = Album.find_by(id: params[:id])
  end
end
