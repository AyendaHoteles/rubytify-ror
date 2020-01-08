class Api::V1::SongsController < ApplicationController

  def index
    song = Song.all
    render json: { data: song }, status: 200
  end

  def show
    song = Song.find_by(id: params[:id])
    render json: { data: song }, status: 200
  end
end
