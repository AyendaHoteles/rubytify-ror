class ArtistsController < ApplicationController
  def index
    artists = Artist.all.order(popularity: :desc)
    render_resources(artists, %i[id name image genres popularity spotify_url])
  end
end
