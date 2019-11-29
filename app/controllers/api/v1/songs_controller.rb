class Api::V1::SongsController < ApplicationController
  before_action :set_song, only: [:show]

  def index
    @songs = Song.all
    render json: @songs
  end

  def show
    render json: @song
  end

  private
  def set_song
    @song = Song.find(params[:id]) 
  end
end
