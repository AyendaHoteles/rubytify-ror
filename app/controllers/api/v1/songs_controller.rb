class Api::V1::SongsController < Api::V1::BaseController
  def index
    @songs = Song.where(params[:album_id])
  end
end
