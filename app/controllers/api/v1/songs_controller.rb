class Api::V1::SongsController < ApplicationController
  before_action :set_song, only: [:show, :update, :destroy]

  # GET /api/v1/songs
  def index
    @songs = Song.all
    render json: @songs
  end

  # GET /api/v1/genres/rock/random_song
  def random
    @artist = Artist.where('genres LIKE ?', "%#{params[:genre_name]}%")
    @random_song = @artist.count > 0 ? @artist.sample.songs.sample : []
    render json: { data: @random_song.as_json(only: %w[name spotify_url preview_url duration_ms explicit]) }
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:genre_name])
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.require(:song).permit(:name, :spotify_url, :preview_url, :duration, :explicit, :spotify_id)
    end
end
