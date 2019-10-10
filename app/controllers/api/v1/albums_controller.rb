class Api::V1::AlbumsController < Api::V1::BaseController
  def index
    @albums = if params[:artist_id]
                Album.where(params[:artist_id])
              else
                Album.all
              end
  end

  def show
    @album = Album.find(params[:id])
  end
end
