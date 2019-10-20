class Api::V1::ArtistsController < ApplicationController
  def index
    render json: Artist.all
  end
end
