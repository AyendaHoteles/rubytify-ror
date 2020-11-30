class Api::V1::ArtistsController < ApplicationController
  def index
      artists = Artist.order(popularity: :desc)
      render_resources(artists, %i[id name image genres popularity spotify_url])
  end
  
  def albums
      artist = Artist.find(params[:id])
      albums = artist.albums
      render_resources(albums, %i[id name image spotify_url total_tracks])
  end
end
