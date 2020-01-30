class Api::V1::ArtistsController < Api::V1::BaseController
  def index
    @artists = Artist
               .select('id, name, image, genres, popularity, spotify_url')
               .order(popularity: :desc)
               .all

    render json: { data: @artists }, status: :ok
  end
end
