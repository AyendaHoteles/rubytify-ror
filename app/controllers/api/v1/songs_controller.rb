class Api::V1::SongsController < ApplicationController
  def index
    def index
      album = Album.find_by(spotify_id: params[:album_id])
      
      if album
        songs = album.songs

        songs_data = songs.map {|song| song.create_body }

        render json: {data: songs_data}.to_json , status: 200
      else
        render status: 204
      end
    end
  end
end