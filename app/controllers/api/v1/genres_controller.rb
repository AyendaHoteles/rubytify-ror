class Api::V1::GenresController < ApplicationController
  def random_song
    serialized_response = ActiveModelSerializers::SerializableResource.new(
      Song.random_song_by_genre(genre_param[:genre_name])
    )
    render json: {
      data: serialized_response
    }
  end

  private

  def genre_param
    params.permit(:genre_name)
  end
end
