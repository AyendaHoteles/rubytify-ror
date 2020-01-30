class Api::V1::SongsController < Api::V1::BaseController
  def index
    @album = Album.find(params[:album_id])
    @songs = @album.songs
  end

  def random
    @song = Song.random_by_genre(params[:genre_name])
    genre_without_matches if @song.nil?
  end

  def genre_without_matches
    render json: {
      error: "No matches for #{params[:genre_name]}"
    }, status: :not_found
  end
end
