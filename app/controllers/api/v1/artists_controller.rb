class Api::V1::ArtistsController < ApplicationController
  before_action :load_artist, only: [:albums]

  def index
    render json: build_response(Artist.order(popularity: :desc), ArtistSerializer)
  end

  def albums
    render json: build_response(@artist.albums, AlbumSerializer)
  end

  private

  def load_artist
    @artist = Artist.find_by(id: params[:id])
  end
end
