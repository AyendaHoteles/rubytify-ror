class Api::V1::ArtistsController < ApplicationController
  # get all artists
  def index
    @artists = Artist.order(popularity: :desc)
    render json: { data: @artists }, except: [:spotify_id, :updated_at, :created_at]
  end

  # get all albums for an artist
  def albums
    @artist = Artist.find(params[:id])
    @albums = Album.where(artist_id: @artist.id)
    render json: { data: @albums }, except: [:spotify_id, :updated_at, :created_at, :artist_id]
  end
end
