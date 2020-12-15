class Api::V1::ArtistsController < ApplicationController
  def index
    @artists = Artist.all
    render json: @artists
  end
end
