class Api::V1::AlbumsController < Api::V1::BaseController
  def index
    @artist = Artist.find(params[:artist_id])
    @albums = @artist
              .albums
              .select('id, name, image, spotify_url, total_tracks')
    render json: { data: @albums }, status: :ok
  end
end
