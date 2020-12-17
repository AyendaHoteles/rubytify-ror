class Api::V1::ArtistsController < ApplicationController
  def index
    @artists = Artist.all.order(popularity: :desc)
    render json: @artists, root: 'data', adapter: :json
  end
end
