class Api::V1::ArtistsController < ApplicationController
  def index
    render json: Artist.all.order(popularity: :desc)
  end
end
