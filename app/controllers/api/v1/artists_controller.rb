class Api::V1::ArtistsController < ApplicationController
  def index
    artists = Artist.all.order('popularity DESC')
    rendering(artists, %i[id name image genres popularity spotify_url])
  end

  def albums
    artist = Album.find(params[:id])
    albums = artist.albums
    rendering(albums, %i[id name image spotify_url total_tracks])
  end
end
