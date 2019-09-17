class Api::V1::GendersController < ApplicationController
  def index
    find_song
  end

  private
  def find_song
    gender = Gender.find_by(name: params[:genre_name])
    if gender == nil || Song.where(gender_id: gender.id).empty?
      render json: { errors: "No hay canciones en este género" }, status: 422
    else
      random_song = Song.where(gender_id: gender.id).sample
      new_object = [{ name: random_song.name, spotify_url: random_song.spotify_url, preview_url: random_song.preview_url, duration_ms: random_song.duration_ms, explicit: random_song.explicit }]
      answer = { data: new_object}
      json_response(answer)
    end
  end

end
