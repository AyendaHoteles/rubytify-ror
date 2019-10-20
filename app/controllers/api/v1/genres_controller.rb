class Api::V1::GenresController < ApplicationController
  before_action :load_genre

  def random_song
    songs = Album.includes(:songs).where(artist_id: @genre.artists.ids).map{ |album| album.songs}.flatten
    random = rand(songs.count - 1)
    song = songs[random]

    render json: song
  end

  def not_register_genre
    render json: { data: { message: 'Not register genre' }}
  end

  private

  def load_genre
    @genre = Genre.find_by(name: params[:genre_name])

    return not_register_genre unless @genre
  end
end
