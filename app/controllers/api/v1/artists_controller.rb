class Api::V1::ArtistsController < ApplicationController
  def index
    @artist = Artist.all
    render json: @artist, root: 'data'
  end
end