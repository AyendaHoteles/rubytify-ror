class Api::V1::SongsController < ApplicationController
  def index
    song_album = Album.find(param_song).songs
    render json: { 'data': ActiveModelSerializers::SerializableResource.new(
      song_album, each_serializer: SongSerializer,
    ) }
  end

  private

  def param_song
    params.require(:album_id)
  end
end
