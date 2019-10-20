class Api::V1::ArtistsController < ApplicationController
  before_action :set_artist, only: :albums

  # GET /artists
  def index
    @artist = Artist.select(:id, :name, :image, :genres, :popularity, :spotify_url).order(popularity: :desc)
    json_response(@artist)
  end

  # GET /albums
  def albums
    @albums = @artist.albums.select(:id, :name, :image, :spotify_url, :total_tracks)
    json_response(@albums)
  end   

  private

  def set_artist
    @artist = Artist.find(params[:id])
  end  
end
