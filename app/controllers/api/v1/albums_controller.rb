class Api::V1::AlbumsController < ApplicationController
  # get all songs for an album
  def songs
    @album = Album.find(params[:id])
    @songs = Song.where(album_id: @album.id)
    render json: { data: @songs }, except: [:id, :spotify_id, :updated_at, :created_at, :album_id]
  end
end
