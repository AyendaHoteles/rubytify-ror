class Api::V1::SongsController < ApplicationController
  def index
    def index
      album = Album.find_by(spotify_id: params[:album_id])

      songs = album.songs

      songs_data = songs.map {|song| song.create_body }

      render json: {data: songs_data}.to_json , status: 200
    end
  end
end
  