class Api::V1::RandomSongController < ApplicationController
  def index
    render json: { 'data': ActiveModelSerializers::SerializableResource.new(
      random_song, each_serializer: SongSerializer,
    ) }
  end

  private

  def random_song
    artist = Artist.where("'#{param_genre}' = ANY (genres)").order("RANDOM()").take
    album = artist.albums.order("RANDOM()").take
    album.songs.order("RANDOM()").take
  end

  def param_genre
    params.require(:genre_id)
  end
end
