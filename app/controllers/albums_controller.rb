class AlbumsController < ApplicationController
  def index
    @data = Album.where(artist_id: params['artist_id'])
  end
end