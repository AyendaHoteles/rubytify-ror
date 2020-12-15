class Api::V1::ArtistsController < ApplicationController
  def index
    @artists = Artist.all
    render json: @artists, root: 'data', adapter: :json
  end
end
