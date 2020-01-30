class Api::V1::SongsController < Api::V1::BaseController
  def index
    @album = Album.find(params[:album_id])
    @songs = @album.songs
  end
end
