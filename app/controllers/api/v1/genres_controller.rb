class Api::V1::GenresController < ApplicationController

  def random_song
    artist = Artist.find_by(genres: params[:genre_name])
    pp artist
    song = artist.albums.first.songs
    ids = song.pluck(:id).shuffle[1]
    render json: { data: song.find_by(id: ids) }, status: 200
  end
end
