class Api::V1::AlbumsController < ApplicationController
  before_action :set_album, only: :songs

  # GET /artists/:id/songs
  def songs
    @songs = @album.songs.select(:id, :name, :spotify_url, :preview_url, :duration_ms, :explicit)
    json_response(@songs)
  end  

  private

  def set_album
    @album = Album.find(params[:id])
  end   
end
