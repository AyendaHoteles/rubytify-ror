class Api::V1::ArtistsController < ApplicationController

  def index
    artist = Artist.all
    render json: { data: artist }, status: 200
  end

  def show
    artist = Artist.find_by(id: params[:id])
    render json: { data: artist },  status: 200
  end
end
