class Api::V1::GenresController < Api::V1::BaseController
  before_action :find_genre, only: %i[index show random]
  before_action :all_genres, only: %i[index show random]

  def index
    @genres = @genres.keys
  end

  def show
    find_artists_of_genre
  end

  def random
    @artists = find_artists_of_genre
    @song = Genre.songs_of(@artists).sample
  end

  private

  def find_genre
    @genre = params[:id]
  end

  def songs_of_array
    Song.where(genre: @genre)
  end

  def all_genres
    @genres = Genre.genres
  end

  def find_artists_of_genre
    @artists = []
    @artists << @genres[@genre]
  end
end
