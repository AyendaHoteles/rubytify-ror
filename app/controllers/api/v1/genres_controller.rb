class Api::V1::GenresController < ApplicationController
  before_action :find_artist, only: [:show]

  def show

    count_artist = @artist_with_genre.count
    random_artist = rand(count_artist)
    count_album = @artist_with_genre[random_artist].albums.count
    random_album = rand(count_album)
    count_song = @artist_with_genre[random_artist].albums[random_album].songs.count
    random_song = rand(count_song)

    @random_song = @artist_with_genre[random_artist].albums[random_album].songs[random_song]

    render json: @random_song, serializer: SongSerializer

  end

  private
    def find_artist
      @artist_with_genre = Artist.artist_genre(params[:genres]) 
    end
  
end


