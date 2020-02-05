# frozen_string_literal: true

class GenresController < ApplicationController
  before_action :valid_genre_name, only: :random_song

  def random_song
    song = artist.songs.sample
    render json: { data: SongSerializer.new(song) }
  end

private

  def artist
    @current_artist = Artist.sample
    @current_artist.search_genre(param_genre) ? @current_artist : artist
  end

  def valid_genre_name
    return render json: {
      error_description: "Ups! El género #{param_genre} no existe"
    } unless Artist.possible_genres.flatten.include?(param_genre)
  end

  def param_genre
    params[:genre_name]
  end
end
