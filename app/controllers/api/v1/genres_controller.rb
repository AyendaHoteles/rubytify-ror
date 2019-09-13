class Api::V1::GenresController < ApplicationController

  def show
   find_random_song
  end

  private
    def find_random_song
      id = Gender.find_by(name: params[:genre_name]).id
      song = Song.where(gender_id: id).sample
      random_object = {
        name: song.name,
        spotify_url: song.spotify_url,
        preview_url: song.preview_url,
        duration_ms: song.duration_ms,
        explicit: song.explicit
      }
      if id.nil?
        render json: { data: "We are under construction"}
      else
        render json: random_object
      end
    end

end
