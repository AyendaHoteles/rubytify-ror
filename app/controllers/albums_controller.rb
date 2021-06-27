class AlbumsController < ApplicationController

  # GET /albums
  def index
    @albums = Album.all

    render json: @albums
  end

  # GET /albums/1
  def show
      @arr = []      
      param = params[:id]
      @album = Album.where(spotify_id_artist: param.to_s)
      render json: "{data:#{@album.to_json(only: [:id, :name, :image, :spotify_url, :total_tracks, :spotify_id])}}"
    rescue ActiveRecord::RecordNotFound => e
      logger.info e
      return render json: { message: 'album is not found' }, status: :not_found 
    rescue => e
      logger.info e
      return render json: { message: 'Is there an error. Try again' }, status: :not_found 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def album_params
      params.require(:album).permit(:name, :image, :total_tracks, :spotify_url, :spotify_id, :spotify_id_artist)
    end
end
