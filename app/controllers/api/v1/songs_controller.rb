class Api::V1::SongsController < ApplicationController
  #GET /api/v1/albums/:id/songs
  def index
    @songs = Album.find(params[:album_id]).songs
    render json: @songs, root: 'data', each_serializer: SongSerializer, adapter: :json, status: :ok
  end

  #GET /api/v1/genres/:genre_name/random_song
  def random_song
    @genre = Artist.where("cast(genres AS VARCHAR) LIKE ?", "%\"#{params[:genre_name]}\"%")
    @artist = @genre.sample
    @song = @artist.albums.sample.songs.sample
    render json: @song, root: 'data', adapter: :json, status: :ok
  end
end
