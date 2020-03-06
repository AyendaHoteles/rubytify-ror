class Api::V1::GenresController < ApplicationController
  def random_song
    render json: {data: Song.random_song_by_genre(genre_param[:genre_name])}
  end

  private

  def genre_param
    params.permit(:genre_name)
  end
end
