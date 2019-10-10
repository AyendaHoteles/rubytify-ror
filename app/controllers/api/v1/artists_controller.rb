class Api::V1::ArtistsController < Api::V1::BaseController
  before_action :find_artist, only: %i[show]
  before_action :find_artist_genres, only: %i[show]

  def index
    @artists = Artist.all
  end

  def show; end

  private

  def find_artist
    @artist = Artist.find(params[:id])
  end

  def find_artist_genres
    @genres = @artist.genres.uniq
  end
end
