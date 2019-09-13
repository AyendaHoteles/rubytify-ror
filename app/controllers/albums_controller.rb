class AlbumsController < ApplicationController
  def index
    @artist = Artist.find(params[:id])
    json_response(@artist.albums)
  end
end
