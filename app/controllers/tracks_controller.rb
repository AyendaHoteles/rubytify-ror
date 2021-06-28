class TracksController < ApplicationController

  # GET /songs
  def index
    @songs = Track.all

    render json: @songs
  end

  # GET /songs/1
  def show
      @arr = []      
      param = params[:id]
      @song = Track.where(spotify_id_album: param.to_s)
      render json: "{data:#{@song.to_json(only: [:id, :name, :preview_url, :spotify_url, :duration_ms, :explicit])}}"
    rescue ActiveRecord::RecordNotFound => e
      logger.info e
      return render json: { message: 'song is not found' }, status: :not_found 
    rescue => e
      logger.info e
      return render json: { message: 'Is there an error. Try again' }, status: :not_found 
  end

  # GET /genres/:genre_name/random_song
  def random
      @arr = []      
      param = params[:genre_name]
      @songs = Track.where("genres like ?", "%#{param}%")
      arrAux = []
      @songs.each do |songAux|
        arrAux.push(songAux)
      end
      limitNumber = arrAux.size
      @strEx = arrAux[Random.rand(limitNumber)]  
      render json: "{data:#{@strEx.to_json(only: [:id, :name, :preview_url, :spotify_url, :duration_ms, :explicit])}}"
    rescue ActiveRecord::RecordNotFound => e
      logger.info e
      return render json: { message: 'song is not found' }, status: :not_found 
    rescue => e
      logger.info e
      return render json: { message: 'Is there an error. Try again' }, status: :not_found 
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def track_params
      params.require(:track).permit(:name, :preview_url, :duration_ms, :spotify_url, :spotify_id, :spotify_id_album, :explicit, :genres)
    end
end
