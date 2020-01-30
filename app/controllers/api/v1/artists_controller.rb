class Api::V1::ArtistsController < Api::V1::BaseController
  def index
    @artists = Artist.all.order(popularity: :desc)
  end
end
