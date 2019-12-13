class Api::V1::AlbumsController < ApplicationController
  def index
    artist = Artist.find(param_artist)
    render json: { 'data': ActiveModelSerializers::SerializableResource.new(
      artist.albums, each_serializer: AlbumSerializer,
    ) }
  end

  private

  def param_artist
    params.require(:artist_id)
  end
end
