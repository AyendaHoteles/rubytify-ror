class Api::V1::AlbumsController < Api::V1::BaseController
  def index
    @artist = Artist.find(params[:artist_id])
    @albums = @artist.albums
  end
end
