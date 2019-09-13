class SongsController < ApplicationController
  def index
    @album = Album.find(params[:id])
    json_response(@album.songs)
  end

end
