class ArtistsController < ApplicationController
  def index
    artists = Artist.all.order('popularity DESC')
    render(
      json: {
        data: artists.map { |artist| ArtistSerializer.new(artist) }
      })
  end

  def albums
    albums = artist.albums
    render(
      json: {
        data: albums.map { |album| AlbumSerializer.new(album)}
      })
  end

  private

  def artist
    Artist.find(params[:id])
  end
end
