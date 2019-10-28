class Api::V1::SongsController < ApplicationController

  def random_song
    if !params[:genre_name].blank?
      render json: { data: Song.left_joins(album: :artist).where("artists.genres ILIKE?", "%rock%").sample(1)[0].details} , status: :ok
    else
      render json: { message: "Genre name params is required"} , status: :bad_request
    end
  end


end