class Api::V1::GenresController < ApplicationController
  def random_song
    single_genre = "% " + params[:genre_name] + " %"
    puts "Genre is: " + single_genre
    @songs = Song.where("genres like ?", single_genre).order('RANDOM()').first
    render json: { data: @songs }
  end
end
