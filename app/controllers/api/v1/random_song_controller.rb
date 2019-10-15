class Api::V1::RandomSongController < ApplicationController
  def index
    song = Song.random_song(genre_name: params[:genre_name])
    
    unless song.nil?
      song_data = song.create_body

      render json: {data: song_data}.to_json , status: 200
    else
      render status: 204
    end
  end
end
