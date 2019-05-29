class Api::V1::SongsController < ActionController::Base

  def random_song_genre

    genre_name = params[:genre_name]
    response = Song::GetRandomSongGenre.call(genre_name)
    render json: response[:response], status: response[:status]
  end

end