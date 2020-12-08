class Api::V1::SongsController < ApplicationController
  def index
    @songs = Track.all
    render json: @songs
  end
end
