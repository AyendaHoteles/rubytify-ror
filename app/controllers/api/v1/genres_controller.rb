class Api::V1::GenresController < Api::V1::BaseController
  before_action :find_genre, only: %i[show random]

  def index
    @genres = Genre.all
  end

  def show
    @total_tracks = songs_of_array.size
  end

  def random
    @song = songs_of_array.sample
  end

  private

  def find_genre
    @genre = Genre.find_by(name: params[:id].capitalize)
  end

  def songs_of_array
    Song.where(genre: @genre)
  end
end
